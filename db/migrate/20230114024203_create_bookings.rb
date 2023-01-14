class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings, id: :uuid do |t|
      t.datetime    :start, null: false
      t.datetime    :end, null: false
      t.belongs_to  :user, null: false, index: true
    end
  end
end
