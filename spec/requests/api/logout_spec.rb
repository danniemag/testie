require 'rails_helper'
require 'shared_contexts'

RSpec.describe "Api Logout", :type => :request do
  include_context "api request authentication helper methods"
  include_context "api request global before and after hooks"

  let(:email) { 'test_user1@example.com' }
  let(:password) { 'password' }

  # Assumes you have FactoryGirl included in your application's test group.
  let!(:user) { create(:user, email: email, password: password) }
end
