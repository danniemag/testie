require 'rails_helper'

RSpec.describe "Bookings", type: :request do
  let(:user) { create(:user) }

  describe "GET #index" do
    context 'when user is signed_out' do
      it 'redirects to authentication page' do
        get "/"

        expect(response).to redirect_to %r(\Ahttp://www.example.com/users/sign_in)
      end
    end

    context 'when user is signed_in' do
      before do
        sign_in user
      end

      it 'renders template' do
        get "/"

        expect(response).to render_template(:index)
      end
    end
  end

  describe "POST #create" do
    before do
      sign_in user
    end

    context "when attributes are valid" do
      let(:valid_params) do
        {
          booking: {
            user_id: user.id,
            starts: "2023-01-15 19:30:00".to_time,
            ends: "2023-01-15 20:00:00".to_time,
            duration: 30
          }
        }
      end

      it "creates a new booking" do
        expect{
          post '/bookings', params: valid_params
        }.to change(Booking,:count).by(1)
      end

      it "returns a message" do
        post '/bookings', params: valid_params
        expect(flash[:success]).to eq('Booking successfully generated')
      end

      it "redirects to the new contact" do
        post '/bookings', params: valid_params
        response.should redirect_to %r(\Ahttp://www.example.com/bookings/user)
      end
    end

    context "when attributes are invalid" do
      let(:invalid_params) do
        {
          booking: {
            starts: "2023-01-15 19:30:00".to_time,
            ends: "2023-01-15 20:00:00".to_time,
            duration: 30
          }
        }
      end

      it "does not save the new contact" do
        expect{
          post '/bookings', params: invalid_params
        }.to_not change(Booking,:count)
      end

      it "returns a message" do
        post '/bookings', params: invalid_params
        expect(flash[:error]).to eq("User can't be blank")
      end
    end
  end

  describe "POST #destroy" do
    before do
      sign_in user

      create_list(:booking, 7)
    end

    it "removes a booking" do
      expect{
        delete '/bookings', params: { id: Booking.first.id }
      }.to change(Booking,:count).by(-1)
    end

    it "returns a message" do
      delete '/bookings', params: { id: Booking.first.id }
      expect(flash[:success]).to eq('Booking successfully deleted')
    end

    it "redirects to the new contact" do
      delete '/bookings', params: { id: Booking.first.id }
      response.should redirect_to %r(\Ahttp://www.example.com/bookings/user)
    end
  end

  describe "GET #user" do
    context 'when user is signed_out' do
      it 'redirects to authentication page' do
        get "/bookings/user"

        expect(response).to redirect_to %r(\Ahttp://www.example.com/users/sign_in)
      end
    end

    context 'when user is signed_in' do
      before do
        sign_in user
      end

      it 'is not redirected' do
        get "/bookings/user"

        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #scheduled" do
    subject(:go!) { get "/bookings/scheduled.json" }

    let(:body) { JSON.parse(response.body) }

    context 'when requesting data' do
      before do
        sign_in user
        create_list(:booking, 10)

        go!
      end

      it 'returns the correct structure' do
        expect(body.first.keys).to contain_exactly('calendarId', 'title', 'start', 'end', 'duration')
      end

      it 'returns all data' do
        expect(body.size).to eq(10)
      end

      it 'returns 200 OK status code' do
        expect(@response.status).to eq(200)
      end
    end
  end
end
