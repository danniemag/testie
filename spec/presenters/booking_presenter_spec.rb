require 'rails_helper'

RSpec.describe BookingPresenter, type: :presenter do
  describe "#to_hash" do
    let(:user) { create(:user) }
    let(:booking) { create(:booking, duration: rand(15..60), user_id: user.id) }

    let(:results) do
      {
        calendarId: 'personal',
        title: 'My Schedule',
        start: booking.starts.strftime('%FT%T'),
        end: booking.ends.strftime('%FT%T'),
        duration: booking.duration
      }
    end

    subject(:presenter) { described_class.new(booking, user.id) }

    it 'returns expected fields' do
      expect(presenter.to_hash.keys).to include(:calendarId, :title, :start, :end, :duration)
    end

    it 'generates a hash for the booking' do
      expect(presenter.to_hash).to eq(results)
    end
  end
end
