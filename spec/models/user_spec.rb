require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  describe 'validators' do
    let(:user) { create(:user) }
    let(:booking) { create(:user) }

    context 'when `email` is nil' do
      before do
        user.email = nil
      end

      it 'raises and error' do
        expect(user.save).to be_falsey
      end
    end

    context 'when `password` is nil' do
      before do
        user.password = nil
      end

      it 'raises and error' do
        expect(user.password).to be_falsey
      end
    end

    context 'when data is valid' do
      it 'saves the object' do
        expect(user.save).to be_truthy
      end

      it 'generates a record' do
        user.save

        expect(User.count).to eq(1)
      end
    end
  end
end
