require 'active_record/fixtures'

FactoryBot.define do
  ## Bookings
  ## ---------------------------------------
  factory :booking do
    association :user, factory: :user
    id       { SecureRandom.uuid }
    starts   { "2023-01-16 00:30:00".to_time  }
    ends     { "2023-01-16 01:00:00".to_time  }
    duration { }
  end

  ## Users
  ## ---------------------------------------
  factory :user do
    email    { 'lorem@ipsum.com' }
    password { "Something@" }
  end
end
