# EventFinder

This program find events in your area or area of choice. You can easilly create a profile, log in, search events, book tickets and resell 
tickets.


## Guide

The Event Finder App has a lot of great features at your disposal. Here are some quick tips so that you get the most out of the application:

From your terminal, run 'bundle install' to install all of the neccessary gems.

To seed the databse run 'rake db:seed' in the terminal

To start the application run 'ruby bin/run.rb' from the terminal

EventFinder app will prompt you to either log in or create an account
  if creating a new account the following information is required - Name - password - City

## Once logged in you will have the following options:  
  
  ### See Events In Your Area
      Shows you events happening in your city
      After selecting an event you will be given additional information and the option to purchase a ticket
  ### Different Area
      Prompts you to select the city you're looking for and shows you events happening in the selected city
      After selecting an event you will be given additional information and the option to purchase a ticket
  ### View Bookings
      Displays all the events you have booked
  ### Sell Tickets
      Gives you the option to sell ticket to any of your current bookings
  ### Account Settings
      Gives you the option to change your current password or delete your account(Please dont leave us :( we are a struggling startup)
  ### Exit
      Logs you out and closes the application

