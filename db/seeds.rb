# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

ActiveRecord::Base.transaction do
    5.times {
        User.create(email: Faker::Internet.email, password: "123456", name: Faker::HarryPotter.character, phone: rand(111111111..999999999), address: Faker::Address.street_address, status: "regular")
    }
end

uids = []
User.all.each {|u| uids << u.id}

ActiveRecord::Base.transaction do
    100.times do
        Friend.create(user1_id: uids.sample, user2_id: uids.sample)
    end
end