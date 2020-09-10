require 'open-uri'
require 'json'
require 'net/http'
require 'pry'
require_relative './config/environment'

require 'faker'

city_list = ["Los Angeles", "New York", "Chicago", "Las Vegas", "Miami"]
# city.sample ==> city
event_list = [Faker::Music.band, Faker::Sports::Basketball.team, Faker::Movie.title]
event_type_list = ["Concert", "Sporting Event", "Movie"]

user_name = Faker::FunnyName.name
password = Faker::Hacker.noun
city = city_list.sample

price = Faker::Commerce.price
date = Faker::Date.in_date_period
city = city_list.sample
venue = Faker::WorldCup.stadium
event_name = event_list.sample
event_type = event_type_list.sample

10.times do
    User.create(user_name: Faker::FunnyName.name, password: Faker::Hacker.noun, city: city_list.sample)
end

5.times do
    Event.create(name: Faker::Music.band, venue: Faker::WorldCup.stadium, date: Faker::Date.in_date_period, price: Faker::Commerce.price, event_type: "Concert", city: city_list.sample)
end

5.times do
    Event.create(name: Faker::Sports::Basketball.team, venue: Faker::WorldCup.stadium, date: Faker::Date.in_date_period, price: Faker::Commerce.price, event_type: "Sporting Event", city: city_list.sample)
end

5.times do
    Event.create(name: Faker::Movie.title, venue: Faker::WorldCup.stadium, date: Faker::Date.in_date_period, price: Faker::Commerce.price, event_type: "Movie", city: city_list.sample)
end


Booking.create(user: user)

# booking1 = Booking.create(user: austin, event: event1)








# def create_events(city, num_of_events)
#     url = "https://app.ticketmaster.com/discovery/v2/events?apikey=7elxdku9GGG5k8j0Xm8KWdANDgecHMV0&locale=*&sort=date,name,asc&city=#{city}"
#     uri = URI.parse(url)
#     response = Net::HTTP.get_response(uri)
#     parsed_page = JSON.parse(response.body)

#     index = 0
#     while index < num_of_events
#         parsed_page.each do |page|
#             event_info = {
#                 name: parsed_page["_embedded"]["events"][index]["name"],
#                 venue: parsed_page["_embedded"]["events"][index]["_embedded"]["venues"][0]["name"],
#                 date: parsed_page["_embedded"]["events"][index]["dates"]["start"]["localDate"],
#                 ## Erroring out because some events don't have pricing info
#                 ## set a default price if not found?
#                 price: parsed_page["_embedded"]["events"][index]["priceRanges"][0]["min"],
#                 event_type: parsed_page["_embedded"]["events"][index]["classifications"][0]["segment"]["name"],
#                 city: city
#             }
#             Event.create(event_info)
#             index +=1
#         end
#     end
# end


# create_events("Chicago", 10)
# # create_events("Las Vegas", 10)
# # create_events("Los Angeles", 10)

# # create_events("Miami", 10)
# # create_events("Chicago", 10)
# # create_events('New York', 10)










#Event.create(name: "Drake Concert", venue: "MSG", date: "2020-09-10 19:00", price: 100, event_type: "Concert", city: "Los Angeles")
## only need to change the first 0 index to iterate through
# NAME parsed_page["_embedded"]["events"][5]["name"]
# DATE parsed_page["_embedded"]["events"][5]["dates"]["start"]["localDate"]
# VENUE parsed_page["_embedded"]["events"][5]["_embedded"]["venues"][0]["name"]
# PRICE parsed_page["_embedded"]["events"][5]["priceRanges"][0]["min"]
# TYPE parsed_page["_embedded"]["events"][5]["classifications"][0]["segment"]["name"]
# CITY --- whatever city we're iterating over


