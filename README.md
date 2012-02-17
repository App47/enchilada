App47 Bulk User Creation
========================================================

# Requirements

* Ruby 1.9.2 
* Bundler 

# Working with Bundler and RVM

This project manages Ruby versions via [RVM](http://rvm.beginrescueend.com/) and manages dependencies via [Bundler](http://gembundler.com/). 

You must first [install RVM](http://rvm.beginrescueend.com/rvm/install/) and then install Ruby 1.9.2 ([version 1.9.2-p136](http://rvm.beginrescueend.com/interpreters/ruby/)) via RVM. You'll now notice that this project contains a .rvmc file, which is executed upon opening the project's root directory in a terminal (and IDE's like RubyMine). The .rvmc file simply states `rvm ruby-1.9.2` which tells RVM to ensure the Ruby version to use for this project is 1.9.2. 

To set up this project's dependencies, which are defined in the file, `Gemfile`, you should first run

        $ bundle install --path vendor

Please note, your Ruby 1.9.2 version might need bundler installed:

        $ gem install bundler

