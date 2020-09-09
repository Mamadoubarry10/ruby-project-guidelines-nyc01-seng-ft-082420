
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
        user_choice = prompt.select("What would you like to do", ["See events in your area", "Different area", "Manage Booking", "Account Setting"])
        
        if user_choice == "See events in your area"
            events = Event.where(:city == @@user[:city])
            event_names = events.map {|event| event[:name]}
            event_selection = prompt.select("Here are the events in your area, click for additional information", event_names)
            ## return the event object based on event_selection... venue, date, price... last option book tickets -- if you book tickets (booking.create)
        end
    end

    


    # Main menu
        ## Do you want to see events in your area #{city from their user table}?
            ## Grab all events from (ticketmaster or our seed data to start) in that city
                ## Display all event information from event.rb (Event.all) and prompt user to select an event for more information on how to book?
                    ## Tickets are x_price, are you sure you'd like to purchase? y/n
                    ## if yes, Booking.create a new booking for that user_id and event_id
                    ## if no, return back to events page in your area

        
        
                # prompt.select("Do you have an account with us?", ["Sign up", "Login", "Change PW"])


    ## Do you have an account with us already?
        ##TTY to ask yes/no questions


    ## If yes, prompt user to login with their login
        ## if login, matches prompt user for PW
            ## another TTY to hide your passwords .mask
            ## if PW is good, you're logged in and drop you in the main_menu
            ## if not, try again

    ## if no, prompt user to start creating an account
        ## will need user_name, password, and your home city
        ## gather all those inputs and create a new User with User.create
        ## after account is setup, main_menu pops up


    ## Main menu
        ## Do you want to see events in your area #{city from their user table}?
            ## Grab all events from (ticketmaster or our seed data to start) in that city
                ## Display all event information from event.rb (Event.all) and prompt user to select an event for more information on how to book?
                    ## Tickets are x_price, are you sure you'd like to purchase? y/n
                    ## if yes, Booking.create a new booking for that user_id and event_id
                    ## if no, return back to events page in your area
    

        ## Do you want to see events somewhere else?
            ## prompt.ask to ask user what city they're looking for (if no results found, prompt them again to try somewhere else)
                ## Grab all events from (ticketmaster or our seed data to start) in that city
                ## Display all event information from event.rb (Event.all) and prompt user to select an event for more information on how to book?
                    ## Tickets are x_price, are you sure you'd like to purchase? y/n
                    ## if yes, Booking.create a new booking for that user_id and event_id
                    ## if no, return back to events page in your area

        ## See what events I'm currently going to?
            ## List all events in a dropdown, after user selects an event
                ## See how much I paid?
                ## Do you want to sell your tickets? y/n

        ## Account settings
            ## Delete my account
            ## Change my PW
            ## return to main menu



end
