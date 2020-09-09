User.destroy_all
Booking.destroy_all
Event.destroy_all

austin = User.create(user_name: "Austin", password: "password", city: "New York")
mamadou = User.create(user_name: "Mamadou", password: "password", city: "Los Angeles")

event1 = Event.create(name: "Soccer Match", venue: "Camp Nou", date: "2020-09-10 19:00", price: 100, event_type: "Sporting Event", city:"New York")

booking1 = Booking.create(user: austin, event: event1)
booking2 = Booking.create(user: mamadou, event: event1)
