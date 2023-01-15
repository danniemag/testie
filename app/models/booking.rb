# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user, class_name: 'User'

  validates_presence_of :starts, :ends, :user_id
end
