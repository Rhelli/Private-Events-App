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
