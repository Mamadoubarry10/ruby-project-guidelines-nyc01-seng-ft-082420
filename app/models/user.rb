require 'tty-prompt'


class User < ActiveRecord::Base

    has_many :bookings
    has_many :events, through: :bookings


    def self.login
        prompt = TTY::Prompt.new

        name = prompt.ask("Welcome back, what is your user name?")
        user = User.find_by(user_name: name)
        if user
            pw = prompt.mask("What is your password?")
            if user[:password] == pw
                puts "Welcome, #{user[:user_name]}"
            else 
                pw = prompt.mask("Incorrect, try again")
                # if you fail a 2nd time it still lets you in... need to fix later
            end
        else 
            puts "We couldn't find your account, please try again"
            name = prompt.ask("What is your user name?")
            if User.find(user_name: name)
                pw = prompt.mask("What is your password?")
            end
        end
    end

 
    def main_menu
        
            user_choice = prompt.select("What would you like to do", ["See events in your area", "Different area", "Manage Booking", "Account Setting"])
     
             if user_choice == "See events in your area"
                 user
             end
    end

end