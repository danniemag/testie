require 'active_record/fixtures'

FactoryBot.define do
  ## Bookings
  ## ---------------------------------------
  factory :booking do
    random_time = %w[2023-01-31T23:00:00 2023-02-01T06:00:00 2023-02-01T10:15:00 2023-02-01T10:45:00
                     2023-02-01T13:55:00 2023-02-01T14:30:00 2023-02-02T10:00:00 2023-02-02T20:00:00
                     2023-02-01T09:00:00 2023-02-01T10:00:00 2023-02-01T11:30:00 2023-02-01T13:00:00]

    association :user, factory: :user
    id       { SecureRandom.uuid }
    starts   { random_time.sample.to_time  }
    ends     { random_time.sample.to_time  }
    duration { }
  end

  ## Users
  ## ---------------------------------------
  factory :user do
    email    { Forgery('email').address }
    password { "Something@" }
  end
end
