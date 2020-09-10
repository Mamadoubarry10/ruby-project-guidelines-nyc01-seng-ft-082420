
## TO DO

## seed from API for the 5 cites we picked (NY, LA, CHI, MIA, VEGAS) kindaa
    ## Grab 20 events from each?

require 'tty-prompt'
require 'pry'
require 'artii'

class CLI

    ## Opens up with some image or prints our app name
        ## Welcome to EventFinder

    def start
        a = Artii::Base.new :font => 'slant'
        puts a.asciify("EVENTFINDER")
            
            prompt = TTY::Prompt.new(active_color: :cyan)
            existing_account = prompt.yes?("Do you have an account with us?")
            system "clear" 
                if existing_account
                    @@user = User.login
                    sleep(2)
                    system "clear"
                else 
                    new_user = prompt.ask("What is your name?")
                    new_pw = prompt.ask("What is your password?")
                    new_city = prompt.select("Where do you live?", ["New York", "Los Angeles", "Chicago", "Miami", "Las Vegas"])
                    @@user = User.create(user_name: new_user, password: new_pw, city: new_city)
                    puts "Welcome, #{new_user}"
                    sleep(2)
                    system "clear"
                end
                main_menu
    end

    def bookings
        @@user.bookings
    end

    def main_menu
        # notice = Pastel.new.cyan.on_white.detach
        prompt = TTY::Prompt.new(active_color: :cyan)
            
        # prompt = TTY::Prompt.new(active_color: :cyan)
        navigation = prompt.select("What would you like to do", ["See Events In Your Area", "Different Area", "Manage Bookings", "Account Settings", "Exit"])
        
        if navigation == "See Events In Your Area"
            system "clear"

            events = Event.where(city: @@user[:city])
            event_names = events.map {|event| event[:name]}
            event_selection = prompt.select("Here are the events in your area, click for additional information", [event_names, "Go Back"])
            event_detail = Event.where(name: event_selection)
            if event_selection == "Go Back"
                system "clear"
                main_menu
            else
                puts "#{event_detail[0][:name]} will be held at #{event_detail[0][:venue]} on #{event_detail[0][:date]}"
                sleep(3)
                book_ticket = prompt.yes?("Tickets are currently $#{event_detail[0][:price]}. Would you like to purchase?")
                if book_ticket && Booking.find_by(user:@@user, event:event_detail[0])
                    puts "Looks like you already bought tickets"
                elsif book_ticket
                    Booking.create(user:@@user, event:event_detail[0])
                    puts "Thank for your purchase. Have fun!"
                else
                    puts "Bummer"
                end
            end
        elsif 
            navigation == "Different Area"
            system "clear"
            new_city = prompt.select("What city are you looking for?", ["New York", "Los Angeles", "Chicago", "Miami", "Las Vegas", "Go Back"])
            if new_city == "Go Back"
                system "clear"
                main_menu
            end
            events = Event.where(city: new_city)
            event_names = events.map {|event| event[:name]}
            event_selection = prompt.select("Here are the events in your area, click for additional information", [event_names, "Go Back"])
            if event_selection == "Go Back"
                system "clear"
                main_menu
            else
                event_detail = Event.where(name: event_selection)
                # binding.pry
                puts "#{event_detail[0][:name]} will be held at #{event_detail[0][:venue]} on #{event_detail[0][:date]}"
                sleep(3)
                
                book_ticket = prompt.yes?("Tickets are currently $#{event_detail[0][:price]}. Would you like to purchase?")
                if book_ticket && Booking.find_by(user:@@user, event:event_detail[0])
                    puts "Looks like you already bought tickets"
                elsif book_ticket
                    Booking.create(user:@@user, event:event_detail[0])
                    puts "Thank for your purchase. Have fun!"
                else
                    puts "Bummer"
                end
            end

        elsif 
            navigation == "Manage Bookings"
            system "clear"

            bookings_array = @@user.bookings

            booking_names = 
                bookings_array.map do |event|
                    Event.find(event[:event_id])[:name]
                end
                
            puts "Here are you current bookings"
            selection = prompt.select("Would you like to sell your tickets? Select the event below", [booking_names, "Go Back"]) 
            
            if selection == "Go Back"
                system "clear"
                main_menu
            else
                event_id = Event.find_by(name: selection)[:id]
                Booking.find_by(user: @@user, event: event_id).destroy
                sleep(3)
                puts "Your tickets have been sold!"
                bookings_array = @@user.bookings
                system "clear"
            end

        elsif
            navigation == "Account Settings"
            system "clear"

            selection = prompt.select("Account Settings", ["Change my password", "Delete my account", "Go Back"])
            
            if selection == "Change my password"
                system "clear"
                new_pw = prompt.mask("What would you like your new password to be?")
                user = User.find(@@user[:id])
                user.update(password: new_pw)
                sleep(3)
                puts "Password updated."
            
            elsif selection == "Delete my account"
                system "clear"
                user = User.find(@@user[:id])
                user.destroy
                sleep(3)
                puts "Account deleted"
                exit
            else
                system "clear"
                main_menu
            end

        else navigation == "Exit"
            exit
        end

        sleep(3)
        system "clear"
        main_menu
    end
end
