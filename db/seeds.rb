User.destroy_all
Booking.destroy_all
Event.destroy_all




austin = User.create(user_name: "Austin", password: "password", city: "New York")
mamadou = User.create(user_name: "Mamadou", password: "password", city: "Los Angeles")

event1 = Event.create(name: "Soccer Match", venue: "Camp Nou", date: "2020-09-10", price: 100, event_type: "Sporting Event", city:"New York")
event2 = Event.create(name: "Football Game", venue: "Camp You", date: "2020-09-10", price: 100, event_type: "Sporting Event", city:"New York")
event3 = Event.create(name: "Drake Concert", venue: "MSG", date: "2020-09-10", price: 100, event_type: "Concert", city: "Los Angeles")


booking1 = Booking.create(user: austin, event: event1)
booking2 = Booking.create(user: mamadou, event: event1)
