# frozen_string_literal: true

class BookingsController < ApplicationController
  def index; end

  def details; end

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
end
