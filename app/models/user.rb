require 'tty-prompt'


class User < ActiveRecord::Base

    has_many :bookings
    has_many :events, through: :bookings


    def self.login
        prompt = TTY::Prompt.new(active_color: :cyan)
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
            if User.find_by(user_name: name)
                pw = prompt.mask("What is your password?")
            else ## THIS NEEDS SOME WORK
                name = prompt.ask("What is your user name?")
                pw = prompt.mask("What is your password?")
            end
        end
        user = User.find_by(user_name: name)
    end


end