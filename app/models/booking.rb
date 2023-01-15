# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :user, class_name: 'User'

  validates_presence_of :starts, :ends, :user_id

  scope :appointments, lambda {|start_date, end_date| where("starts >= ? AND ends <= ?", start_date, end_date )}
end
