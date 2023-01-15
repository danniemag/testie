# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Create Users -------------------
user1 = User.create(email: 'one@tlink.com', password: 'userOne*')
user2 = User.create(email: 'two@tlink.com', password: 'userTwo*')

# Preset Bookings ----------------
datamodel = [
  { "id": "bd8fc476-ac50-3327-4ece-d73897796852", "starts": "2023-02-01T20:00:00.000Z", "ends": "2023-02-01T22:30:00.000Z", duration: (("2023-02-01T20:00:00.000Z".to_datetime - "2023-02-01T22:30:00.000Z".to_datetime) * 24 * 60).to_i, user_id: user1.id },
  { "id": "8c73d0ca-d999-4081-1558-e5ee6a40fcc2", "starts": "2023-01-31T23:00:00.000Z", "ends": "2023-02-01T06:00:00.000Z", duration: (("2023-02-01T06:00:00.000Z".to_datetime - "2023-01-31T23:00:00.000Z".to_datetime) * 24 * 60).to_i, user_id: user2.id },
  { "id": "086e3a96-2c74-3d2a-e839-ad10c82626d5", "starts": "2023-02-01T10:15:00.000Z", "ends": "2023-02-01T10:45:00.000Z", duration: (("2023-02-01T10:45:00.000Z".to_datetime - "2023-02-01T10:15:00.000Z".to_datetime) * 24 * 60).to_i, user_id: user1.id },
  { "id": "9e323a9e-adf9-605f-9386-c939a9a6af3f", "starts": "2023-02-01T13:55:00.000Z", "ends": "2023-02-01T14:30:00.000Z", duration: (("2023-02-01T14:30:00.000Z".to_datetime - "2023-02-01T13:55:00.000Z".to_datetime) * 24 * 60).to_i, user_id: user1.id },
  { "id": "0510de47-c86e-a64c-bb86-461c039b1012", "starts": "2023-02-02T10:00:00.000Z", "ends": "2023-02-02T20:00:00.000Z", duration: (("2023-02-02T20:00:00.000Z".to_datetime - "2023-02-02T10:00:00.000Z".to_datetime) * 24 * 60).to_i, user_id: user2.id },
  { "id": "4b24e6ab-bdc6-6b2c-e405-a8e01f0fde84", "starts": "2023-02-01T09:00:00.000Z", "ends": "2023-02-01T10:00:00.000Z", duration: (("2023-02-01T10:00:00.000Z".to_datetime - "2023-02-01T09:00:00.000Z".to_datetime) * 24 * 60).to_i, user_id: user2.id },
  { "id": "087ddebe-dd41-7e39-bda8-f617d8c4385d", "starts": "2023-02-01T11:30:00.000Z", "ends": "2023-02-01T13:00:00.000Z", duration: (("2023-02-01T13:00:00.000Z".to_datetime - "2023-02-01T11:30:00.000Z".to_datetime) * 24 * 60).to_i, user_id: user1.id },
  { "id": "5117e557-8d86-4180-9326-1ce0cf733982", "starts": "2023-02-01T13:00:00.000Z", "ends": "2023-02-01T13:10:00.000Z", duration: (("2023-02-01T13:10:00.000Z".to_datetime - "2023-02-01T13:00:00.000Z".to_datetime) * 24 * 60).to_i, user_id: user2.id }
]
Booking.create(datamodel)
