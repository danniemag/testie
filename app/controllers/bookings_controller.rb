# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :set_booking, only: :destroy
  before_action :get_user_bookings, only: %i[new user]
  def index; end

  def new
    @booking = Booking.new

    result_data = ::SetsAvailableSlots.call(params[:starts].to_date, params[:duration].to_i)

    if result_data.success
      @available_slots = result_data.message
    else
      flash[:error] = result_data.message
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @booking = Booking.new(
      booking_params.merge(ends: params[:booking][:starts].to_time + (params[:booking][:duration].to_i).minutes)
    )

    if @booking.save
      flash[:success] = "Booking successfully generated"

      redirect_to user_bookings_path
    else
      @booking.errors.full_messages.each do |message|
        flash[:error] = message
      end

      render :index
    end
  end

  def destroy
    @booking.destroy

    flash[:success] = "Booking successfully deleted"

    redirect_to user_bookings_path
  end

  def user; end

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

  def get_user_bookings
    @user_bookings = Booking.where(user_id: current_user.id).where('starts > ?', Date.today).order(:starts)
  end
end
