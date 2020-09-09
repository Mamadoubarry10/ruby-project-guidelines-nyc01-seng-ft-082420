
## TO DO
## clear screen after a selection
## company logo
## change colors of selections in general (go back/exit)
## seed from API for the 5 cites we picked (NY, LA, CHI, MIA, VEGAS)
    ## Grab 20 events from each?
## include date in our event selectors


require 'tty-prompt'
require 'pry'
require 'artii'

class CLI

    ## Opens up with some image or prints our app name
        ## Welcome to EventFinder

    def start
        a = Artii::Base.new :font => 'slant'
        puts a.asciify("EVENTFINDER")
            
            prompt = TTY::Prompt.new
            existing_account = prompt.yes?("Do you have an account with us?") 
                if existing_account
                    @@user = User.login
                else 
                    new_user = prompt.ask("What is your name?")
                    new_pw = prompt.ask("What is your password?")
                    new_city = prompt.select("Where do you live?", ["New York", "Los Angeles", "Chicago", "Miami", "Las Vegas"])
                    @@user = User.create(user_name: new_user, password: new_pw, city: new_city)
                    puts "Welcome, #{new_user}"
                end
                main_menu
    end

    def main_menu
            
        prompt = TTY::Prompt.new
        navigation = prompt.select("What would you like to do", ["See Events In Your Area", "Different Area", "Manage Bookings", "Account Settings", "Exit"])
        
        if navigation == "See Events In Your Area"

            events = Event.where(city: @@user[:city])
            event_names = events.map {|event| event[:name]}
            event_selection = prompt.select("Here are the events in your area, click for additional information", [event_names, "Go Back"])
            event_detail = Event.where(name: event_selection)
            if event_selection == "Go Back"
                main_menu
            else
                puts "Your event, #{event_detail[0][:name]}, will be held at #{event_detail[0][:venue]} on #{event_detail[0][:date]}"
                sleep(3)
                book_ticket = prompt.yes?("Tickets are currently $#{event_detail[0][:price]}. Would you like to purchase?")
                if book_ticket && Booking.find_by(user:@@user, event:event_detail[0])
                    puts "Looks like you already bought tickets"
                elsif book_ticket
                    Booking.create(user:@@user, event:event_detail[0])
                    puts "Have fun"
                else
                    puts "Bummer"
                end
            end
        elsif 
            navigation == "Different Area"
            new_city = prompt.select("What city are you looking for?", ["New York", "Los Angeles", "Chicago", "Miami", "Las Vegas", "Go Back"])
            if new_city == "Go Back"
                main_menu
            end
            events = Event.where(city: new_city)
            event_names = events.map {|event| event[:name]}
            event_selection = prompt.select("Here are the events in your area, click for additional information", [event_names, "Go Back"])
            if event_selection == "Go Back"
                main_menu
            else
                event_detail = Event.where(name: event_selection)
                # binding.pry
                puts "Your event, #{event_detail[0][:name]}, will be held at #{event_detail[0][:venue]} on #{event_detail[0][:date]}"
                sleep(3)
                
                book_ticket = prompt.yes?("Tickets are currently $#{event_detail[0][:price]}. Would you like to purchase?")
                if book_ticket && Booking.find_by(user:@@user, event:event_detail[0])
                    puts "Looks like you already bought tickets"
                elsif book_ticket
                    Booking.create(user:@@user, event:event_detail[0])
                    puts "Have fun"
                else
                    puts "Bummer"
                end
            end

        elsif 
            navigation == "Manage Bookings"
        
            bookings_array = @@user.bookings
            
            booking_names = 
                bookings_array.map do |event|
                    Event.find(event[:event_id])[:name]
                end
                
            puts "Here are you current bookings"
            
            selection = prompt.select("Would you like to sell your tickets? Select the event below", [booking_names, "Go Back"]) 
            
            if selection == "Go Back"
                main_menu
            else
                event_id = Event.find_by(name: selection)[:id]
                Booking.find_by(user: @@user, event: event_id).destroy
                sleep(3)
                puts "Your tickets have been sold!"
            end

        elsif
            navigation == "Account Settings"

            selection = prompt.select("Account Settings", ["Change my password", "Delete my account", "Go Back"])
            
            if selection == "Change my password"
                new_pw = prompt.mask("What would you like your new password to be?")
                user = User.find(@@user[:id])
                user.update(password: new_pw)
                sleep(3)
                puts "Password updated."
            
            elsif selection == "Delete my account"
                user = User.find(@@user[:id])
                user.destroy
                sleep(3)
                puts "Account deleted"
                exit
            else
                main_menu
            end

        else navigation == "Exit"
            exit
        end

        sleep(3)
        main_menu
    end
end
