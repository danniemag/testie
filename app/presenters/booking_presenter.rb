# frozen_string_literal: true

class BookingPresenter
  attr_reader :booking, :user_id

  #
  # @param booking [Booking]
  # @param user_id [Integer]
  # @return [BookingPresenter]
  #
  def initialize(booking, user_id)
    @booking = booking
    @user_id = user_id
  end

  def to_hash
    {} if booking.blank?

    booking_info = restricted_information

    {
      # Ignoring Rails conventions in favor of feeding JS
      calendarId: booking_info.first,
      title: booking_info.last,
      start: booking.starts.utc.strftime('%FT%T'),
      end: booking.ends.utc.strftime('%FT%T'),
    }
  end

  def to_json(*)
    to_hash.to_json
  end

  def restricted_information
    booking.user_id == user_id ? ['personal', 'My Schedule'] : %w[unavailable Unavailable]
  end
end
