# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'Steve')

29.times do
  name = Faker::Name.name
  User.create!(name: name)
end

=begin 
80.times do
  name = Faker::Lorem.sentence(word_count: 4)
  event_date = Faker::Time.between_dates(from: Date.today - 30, to: Date.today + 500, period: :day)
  created_at = Faker::Time.between_dates(from: Date.today - 500, to: Date.today - 31, period: :day)
  creator_id = rand(1..30)
  description = Faker::Lorem.question(word_count: 15)
  Event.create!(
    name: name,
    event_date: event_date,
    created_at: created_at,
    updated_at: created_at,
    creator_id: creator_id,
    description: description
  )
end
=end

desc_gen = Faker::Lorem.sentence(word_count: 20)

# Past Event Generator
iteration = 1
month = 8
created_month = 7
creator_id = 2

5.times do
  Event.create!(name: "Past Event #{iteration}", event_date: "2019-0#{month}-02 21:00:00 UTC", created_at: "2019-0#{created_month}-01 12:00:00 UTC", updated_at: "2019-0#{created_month}-01 12:00:00 UTC", creator_id: "#{creator_id}", description: "#{desc_gen}")
  iteration += 1
  month -= 1
  created_month -= 1
  creator_id += 1
end


# Future Event Generator
i = 1
month = 4
created_month = 1
creator_id = 5

3.times do
  Event.create!(name: "Future Event #{i}", event_date: "2021-0#{month}-02 22:00:00 UTC", created_at: "2021-0#{created_month}-01 12:00:00 UTC", updated_at: "2021-0#{created_month}-01 12:00:00 UTC", creator_id: "#{creator_id}", description: "#{desc_gen}")
  i += 1
  month += 1
  created_month += 1
  creator_id += 1
end

# User 1s Future Events Gen
event = 6
3.times do
  Invitation.create!(event_attendee_id: '1', invited_to_event_id: "#{event}", rsvp: 'false')
  event += 1
end

# User 1s Past Events Gen - RSVP True
event2 = 5
3.times do
  Invitation.create!(event_attendee_id: '1', invited_to_event_id: "#{event2}", rsvp: 'true')
  event2 -= 1
end

# User 1s Past Events Gen - RSVP False
event3 = 2
2.times do
  Invitation.create!(event_attendee_id: '1', invited_to_event_id: "#{event3}", rsvp: 'false')
  event3 -= 1
end
