
require 'tty-prompt'
require 'pry'

class CLI

    ## Opens up with some image or prints our app name
        ## Welcome to EventFinder


    def start
        puts "Welcome to EventFinder (working title)"
        puts "Company LOGO"
            
            prompt = TTY::Prompt.new
            existing_account = prompt.yes?("Do you have an account with us?") 
                if existing_account
                    @@user = User.login
                else 
                    new_user = prompt.ask("What is your name?")
                    new_pw = prompt.ask("What is your password?")
                    new_city = prompt.ask("What is your city?")
                    @@user = User.create(user_name: new_user, password: new_pw, city: new_city)
                    puts "Welcome, #{new_user}"
                end
                main_menu
    end

    def main_menu
        prompt = TTY::Prompt.new
        user_choice = prompt.select("What would you like to do", ["See Events In Your Area", "Different Area", "Manage Bookings", "Account Settings"])
        
        if user_choice == "See Events In Your Area"
            events = Event.where(city: @@user[:city])
            event_names = events.map {|event| event[:name]}
            event_selection = prompt.select("Here are the events in your area, click for additional information", event_names)
            event_detail = Event.where(name: event_selection)

            puts "Your event, #{event_detail[0][:name]}, will be held at #{event_detail[0][:venue]} on #{event_detail[0][:date]}"
            sleep(3)
            book_ticket = prompt.yes?("Tickets are currently $#{event_detail[0][:price]}. Would you like to purchase?")
            if book_ticket && Booking.find_by(user:@@user, event:event_detail[0])
                puts "Looks like you already bought tickets"
            elsif book_ticket
                Booking.create(user:@@user, event:event_detail[0])
                puts "Have fun"
            else
                puts "Are you sure?"
            end

        elsif user_choice == "Different Area"
            new_city = prompt.ask("What city are you looking for?")
            events = Event.where(city: new_city)
            event_names = events.map {|event| event[:name]}
            event_selection = prompt.select("Here are the events in your area, click for additional information", event_names)
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
                puts "Are you sure?"
            end

        elsif user_choice == "Manage Bookings"
            
            bookings_array = @@user.bookings
            
            booking_names = 
                bookings_array.map do |event|
                    Event.find(event[:event_id])[:name]
                end
                
                puts "Here are you current bookings"
                destroy_booking = prompt.select("Would you like to sell your tickets? Select the event below", booking_names) 
                event_id = Event.find_by(name: destroy_booking)[:id]
                Booking.find_by(user: @@user, event: event_id).destroy
                sleep(3)
                puts "Your tickets have been sold!"

        else 
            
            user_choice = prompt.select("Account Settings", ["Change my password", "Delete my account"])
            
            if user_choice == "Change my password"
                new_pw = prompt.mask("What would you like your new password to be?")
                user = User.find(@@user[:id])
                user.update(password: new_pw)
                sleep(3)
                puts "Password updated."
            
            else
                user = User.find(@@user[:id])
                user.destroy
                sleep(3)
                puts "Account deleted"
            end


        end

        # have something that returns you to a selection screen
    end

end





    ## If yes, prompt user to login with their login
        ## if login, matches prompt user for PW
            ## another TTY to hide your passwords .mask
            ## if PW is good, you're logged in and drop you in the main_menu
            ## if not, try again --- this fails if we type it in twice???




        ## See what events I'm currently going to?
            ## List all events in a dropdown, after user selects an event
                ## See how much I paid?
                ## Do you want to sell your tickets? y/n

