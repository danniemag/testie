class SetsAvailableSlots
  # An instance of this class is returned from
  # {GeneratesAvailableSlots} to indicate success or failure.
  class Result
    attr_reader :success, :message

    def initialize(success:, message: nil)
      @success = success
      @message = message
    end

    # @result [Hash]
    def to_hash
      { success: success, message: message }
    end
  end

  #
  # @see #initialize
  # @see #call
  def self.call(*args)
    new(*args).()
  end

  # @param chosen_date [Time]
  # @param duration [Integer]
  # @param available_slots [Array]
  def initialize(chosen_date, duration, available_slots: [])
    @chosen_date = chosen_date
    @duration = duration
    @available_slots = available_slots
  end

  def call
    error_message = if chosen_date.blank?
                      'Date cannot be blank'
                    elsif chosen_date < Date.today
                      "Cannot choose a past date [#{chosen_date}]"
                    end

    return Result.new(success: error_message.blank?, message: error_message.presence) if error_message

    Result.new(success: true, message: get_range_parameters)
  end

  private

  attr_reader :chosen_date, :duration, :available_slots














  # chosen_date = params[:starts].to_date
  # duration = params[:duration].to_i
  #
  # if chosen_date.blank?
  #   flash[:error] = "Date cannot be blank"
  #   redirect_back(fallback_location: root_path)
  # elsif chosen_date < Date.today
  #   flash[:error] = "Cannot choose a past date [#{params[:starts]}]"
  #   redirect_back(fallback_location: root_path)
  # else
  #   bookings = find_bookings(chosen_date)
  #
  #   t = (chosen_date == Date.today) ? Time.now.utc : chosen_date.to_time.utc.beginning_of_day
  #   slot_multiple_of_fifteen = (t - t.sec - (t.min % 15 * 60)) + duration.minutes
  #
  #   (slot_multiple_of_fifteen.to_i..slot_multiple_of_fifteen.end_of_day.to_i).to_a.in_groups_of(15.minutes).collect(&:first).collect do |t|
  #     next if has_overlapping?(bookings, Time.at(t), duration)
  #     @available_slots << Time.at(t).utc
  #   end
  #   @available_slots
  # end

  def get_range_parameters
    bookings = find_bookings(chosen_date)

    all_fifteen_slots = set_slots

    # Collect the ones which do not overlap any booking
    all_fifteen_slots.collect do |sl|
      next if overlaps_any?(bookings, Time.at(sl), duration)
      available_slots << Time.at(sl).utc
    end

    available_slots
  end

  def find_bookings(date)
    Booking.where('starts BETWEEN ? AND ? OR ends BETWEEN ? AND ?',
                  date.beginning_of_day, date.end_of_day, date.beginning_of_day, date.end_of_day)
           .pluck(:starts, :ends)
  end

  def set_slots
    # Choose whether time will be set from that specific time on (date == today)
    # or from the beginning of the day on (date != today)
    t = (chosen_date == Date.today) ? Time.now : chosen_date.to_time.utc.beginning_of_day
    slot_multiple_of_fifteen = (t - t.sec - (t.min % 15 * 60)) + duration.minutes

    # Set all possible slots multiples of 15
    (slot_multiple_of_fifteen.to_i..slot_multiple_of_fifteen.end_of_day.to_i)
      .to_a
      .in_groups_of(15.minutes)
      .collect(&:first)
  end

  def overlaps_any?(bookings, slot, duration)
    # Check whether a slot overlaps current set bookings
    overlaps = false

    bookings.map do |booking|
      overlaps = (slot..slot + (duration-1).minutes).overlaps?(booking.first..booking.last)
      break if overlaps
    end

    overlaps
  end
end
