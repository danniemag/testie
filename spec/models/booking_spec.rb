require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'validators' do
    let(:booking) { create(:booking) }

    context 'when `starts` is nil' do
      before do
        booking.starts = nil
      end

      it 'raises and error' do
        expect(booking.save).to be_falsey
      end
    end

    context 'when `ends` is nil' do
      before do
        booking.ends = nil
      end

      it 'raises and error' do
        expect(booking.save).to be_falsey
      end
    end

    context 'when `user_id` is nil' do
      before do
        booking.user_id = nil
      end

      it 'raises and error' do
        expect(booking.save).to be_falsey
      end
    end

    context 'when data is valid' do
      it 'saves the object' do
        expect(booking.save).to be_truthy
      end

      it 'generates a record' do
        booking.save

        expect(Booking.count).to eq(1)
      end
    end
  end
end
