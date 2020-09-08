require 'open-uri'
require 'json'
require 'net/http'


url = "https://app.ticketmaster.com/discovery/v2/events?apikey=7elxdku9GGG5k8j0Xm8KWdANDgecHMV0&postalCode=10001&locale=*"
uri = URI.parse(url)
response = Net::HTTP.get_response(uri)
parsed_page = JSON.parse(response.body)

puts parsed_page["_embedded"]["events"][0]["name"]
puts parsed_page["_embedded"]["events"][1]["name"]
puts parsed_page["_embedded"]["events"][2]["name"]
puts parsed_page["_embedded"]["events"][3]["name"]
