class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings, id: :uuid do |t|
      t.datetime    :starts, null: false
      t.datetime    :ends, null: false
      t.integer     :duration
      t.belongs_to  :user, null: false, index: true
    end
  end
end
