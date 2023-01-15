# frozen_string_literal: true

class BookingsController < ApplicationController
  def index; end

  def new; end

  def create
    x=0
  end

  def check_slots
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

      @available_slots = []

      t = chosen_date.to_datetime.utc
      slot_multiple_of_fifteen = (t - t.sec - (t.min % 15 * 60)) + 15.minutes

      (slot_multiple_of_fifteen.to_i..slot_multiple_of_fifteen.end_of_day.to_i).to_a.in_groups_of(15.minutes).collect(&:first).collect do |t|
        next if has_overlapping?(bookings, Time.at(t).utc, duration)
        @available_slots << Time.at(t).utc
      end
      @available_slots
    end
  end

  def scheduled
    render json: response_dataset, status: :ok
  end

  private

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
      overlaps = (slot..slot + duration.minutes).overlaps?(booking.first..booking.last)
      break if overlaps
    end

    overlaps
  end
end
