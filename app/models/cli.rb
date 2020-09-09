
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
            new_city = prompt.ask("What city are you looking for?")
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


# def events_in_your_area
    
#     events = Event.where(city: @@user[:city])
#     event_names = events.map {|event| event[:name]}
#     event_selection = prompt.select("Here are the events in your area, click for additional information", event_names)
#     event_detail = Event.where(name: event_selection)

#     puts "Your event, #{event_detail[0][:name]}, will be held at #{event_detail[0][:venue]} on #{event_detail[0][:date]}"
#     sleep(3)
#     book_ticket = prompt.yes?("Tickets are currently $#{event_detail[0][:price]}. Would you like to purchase?")
#     if book_ticket && Booking.find_by(user:@@user, event:event_detail[0])
#         puts "Looks like you already bought tickets"
#     elsif book_ticket
#         Booking.create(user:@@user, event:event_detail[0])
#         puts "Have fun"
#     else
#         puts "Are you sure?"
#     end
# end




    ## If yes, prompt user to login with their login
        ## if login, matches prompt user for PW
            ## another TTY to hide your passwords .mask
            ## if PW is good, you're logged in and drop you in the main_menu
            ## if not, try again --- this fails if we type it in twice???




        ## See what events I'm currently going to?
            ## List all events in a dropdown, after user selects an event
                ## See how much I paid?
                ## Do you want to sell your tickets? y/n

