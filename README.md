# App47 Bulk User Creation

This is a simple code base that allows you to quickly bulk add users into the App47 System. Right now, the supported format is an Excel file (see an example file in the `etc/` directory). All that's needed is a user's name, email, and an auto-approve flag (true or false are accepted values). Finally, you'll need your App47 Account's API token, which can be found in the Account section of the Dashboard.

## Requirements

* Ruby 1.9.2 
* Bundler 

## Working with Bundler and RVM

This project manages Ruby versions via [RVM](http://rvm.beginrescueend.com/) and manages dependencies via [Bundler](http://gembundler.com/). 

You must first [install RVM](http://rvm.beginrescueend.com/rvm/install/) and then install Ruby 1.9.2 ([version 1.9.2-p136](http://rvm.beginrescueend.com/interpreters/ruby/)) via RVM. You'll now notice that this project contains a .rvmc file, which is executed upon opening the project's root directory in a terminal (and IDE's like RubyMine). The .rvmc file simply states `rvm ruby-1.9.2` which tells RVM to ensure the Ruby version to use for this project is 1.9.2. 

To set up this project's dependencies, which are defined in the file, `Gemfile`, you should first run

        $ bundle install --path vendor

Please note, your Ruby 1.9.2 version might need bundler installed:

        $ gem install bundler

## How to use Enchilada

Enchilada is simple: there is a sample Excel file in the `etc/` directory. This file has 3 columns: name, email, and an auto-approve flag. Simply fill this file in with user data -- you can put as many as you need. 

Next, obtain your App47 Account Management API token. You can find this in the Account section of the App47 Dashboard -- you should see an API tab. In that tab, you'll find a token (it'll look something like ZSUWSDOtxOdqpzJ9u2A4QIg; that is, it'll be a random sequence of characters).

With your Excel file and token handy, you can then add users by simply typing at the command line:

`ruby whole_enchilada.rb -f <path_to_your_excel_file> -t <your_api_token>`