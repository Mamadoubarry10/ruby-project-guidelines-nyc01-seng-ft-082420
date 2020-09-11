require 'pry'
require 'faker'

User.destroy_all
Booking.destroy_all
Event.destroy_all


austin = User.create(user_name: "Austin", password: "password", city: "New York")
mamadou = User.create(user_name: "Mamadou", password: "password", city: "Los Angeles")

date = Faker::Date.in_date_period(year: 2021)

event1 = Event.create(name: "Soccer Match - #{date}", venue: "Camp Nou", date: date, price: 100, event_type: "Sporting Event", city:"New York")
event2 = Event.create(name: "Football Game - #{date}", venue: "Camp You", date: date, price: 100, event_type: "Sporting Event", city:"New York")
event3 = Event.create(name: "Drake Concert - #{date}", venue: "MSG", date: date, price: 100, event_type: "Concert", city: "Los Angeles")

booking1 = Booking.create(user: austin, event: event1)
booking2 = Booking.create(user: mamadou, event: event1)


city_list = ["Los Angeles", "New York", "Chicago", "Las Vegas", "Miami"]

# 10.times do
#     User.create(user_name: Faker::FunnyName.name, password: Faker::Hacker.noun, city: city_list.sample)
# end

15.times do
    date = Faker::Date.in_date_period(year: 2021)
    Event.create(name: "#{Faker::Music.band} - #{date}" , venue: Faker::WorldCup.stadium, date: date, price: Faker::Commerce.price, event_type: "Concert", city: city_list.sample)
end

15.times do
    date = Faker::Date.in_date_period(year: 2021)
    Event.create(name: "#{Faker::Sports::Basketball.team} vs. #{Faker::Sports::Basketball.team} - #{date}", venue: Faker::WorldCup.stadium, date: date, price: Faker::Commerce.price, event_type: "Sporting Event", city: city_list.sample)
end

15.times do
    date = Faker::Date.in_date_period(year: 2021)
    Event.create(name: "#{Faker::Movie.title} - #{date}", venue: Faker::WorldCupq.stadium, date: date, price: Faker::Commerce.price, event_type: "Movie", city: city_list.sample)
end


# city.sample ==> city
# event_list = [Faker::Music.band, Faker::Sports::Basketball.team, Faker::Movie.title]
# event_type_list = ["Concert", "Sporting Event", "Movie"]

# user_name = Faker::FunnyName.name
# password = Faker::Hacker.noun
# city = city_list.sample

# price = Faker::Commerce.price
# date = Faker::Date.in_date_period
# city = city_list.sample
# venue = Faker::WorldCup.stadium
# event_name = event_list.sample
# event_type = event_type_list.sample