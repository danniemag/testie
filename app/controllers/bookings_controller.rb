# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :set_booking, only: %i[edit destroy]
  before_action :get_user_bookings, only: %i[new user]
  def index; end

  def new
    @booking = Booking.new
    @available_slots = []

    chosen_date = params[:starts].to_date
    duration = params[:duration].to_i

    if chosen_date.blank?
      flash[:error] = "Date cannot be blank"
      redirect_back(fallback_location: root_path)
    elsif chosen_date < Date.today
      flash[:error] = "Cannot choose a past date [#{params[:starts]}]"
      redirect_back(fallback_location: root_path)
    else
      bookings = find_bookings(chosen_date)

      t = (chosen_date == Date.today) ? Time.now.utc : chosen_date.to_time.utc.beginning_of_day
      slot_multiple_of_fifteen = (t - t.sec - (t.min % 15 * 60)) + duration.minutes

      (slot_multiple_of_fifteen.to_i..slot_multiple_of_fifteen.end_of_day.to_i).to_a.in_groups_of(15.minutes).collect(&:first).collect do |t|
        next if has_overlapping?(bookings, Time.at(t), duration)
        @available_slots << Time.at(t).utc
      end
      @available_slots
    end
  end

  def create
    @booking = Booking.new(booking_params.merge(ends: params[:booking][:starts].to_time + (params[:booking][:duration].to_i).minutes))

    if @booking.save
      flash[:success] = "Appointment successfully scheduled"
      redirect_to user_bookings_path
    else
      @booking.errors.full_messages.each do |message|
        flash[:error] = message
      end
      render :index
    end
  end

  def edit; end

  def update; end

  def destroy
    @booking.destroy
    flash[:success] = "Appointment successfully deleted"

    redirect_to user_bookings_path
  end

  def user
    @my_schedules = Booking.where(user_id: current_user.id)
  end

  def scheduled
    render json: response_dataset, status: :ok
  end

  private

  def booking_params
    params.require(:booking).permit(:starts, :ends, :duration, :user_id)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def response_dataset
    results.map do |booking|
      ::BookingPresenter.new(booking, current_user.id).to_hash
    end
  end

  def results
    Booking.where('ends > ?', Date.today.beginning_of_week)
  end

  def find_bookings(date)
    Booking.where('starts BETWEEN ? AND ? OR ends BETWEEN ? AND ?',
                  date.beginning_of_day, date.end_of_day, date.beginning_of_day, date.end_of_day)
           .pluck(:starts, :ends)
  end

  def has_overlapping?(bookings, slot, duration)
    overlaps = false

    bookings.map do |booking|
      overlaps = (slot..slot + (duration-1).minutes).overlaps?(booking.first..booking.last)
      break if overlaps
    end

    overlaps
  end

  def get_user_bookings
    @user_bookings = Booking.where(user_id: current_user.id).where('starts > ?', Date.today).order(:starts)
  end
end
