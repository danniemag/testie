require 'rails_helper'

RSpec.describe SetsAvailableSlots, type: :service do
  describe "class" do
    describe ".call" do
      let(:chosen_date) { Time.now.tomorrow }

      let(:duration) { 30 }

      it 'creates a new instance of the service and calls it' do
        service_instance = double(described_class)
        allow(described_class).to receive(:new).with(chosen_date, duration).and_return(service_instance)
        allow(described_class).to receive(:call).and_return('the end result')
        expect(described_class.call(chosen_date, duration)).to eq 'the end result'
      end
    end
  end

  describe "#call" do
    subject(:service) { described_class.new(chosen_date, duration) }

    context 'when date is blank' do
      let(:chosen_date) { '' }
      let(:duration) { 30 }

      it 'returns a failure response' do
        expect(subject.call.success).to be_falsey
      end

      it 'returns a message' do
        expect(subject.call.message).to eq('Date cannot be blank')
      end
    end

    context 'when date is older than current time' do
      let(:chosen_date) { Time.now.yesterday }
      let(:duration) { 30 }

      it 'returns a failure response' do
        expect(subject.call.success).to be_falsey
      end

      it 'returns a message' do
        expect(subject.call.message).to eq("Cannot choose a past date [#{chosen_date}]")
      end
    end

    context 'when data is valid' do
      let(:chosen_date) { Time.now.tomorrow }
      let(:duration) { 30 }
        it 'returns an Array of slots' do
          expect(subject.call.message.class).to eq(Array)
        end

        it 'returns only slots multiples of 15' do
          subject.call.message.each do |time|
            expect(time.min % 15).to eq(0)
          end
        end
    end
  end
end