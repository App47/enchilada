# App47 Bulk User Creation

This is a simple code base that allows you to quickly bulk add users into the [App47](http://www.app47.com) System. Right now, the supported format is an Excel file (see an example file in the `etc/` directory). All that's needed is a user's name, email, an auto-approve flag (true or false are accepted values), and an optional group; what's more, you can set _when_ a temporary invitation password will expire (value is specified in hours) and you can specify the invitation message that user receives. Finally, you'll need your App47 Account's API token, which can be found in the Account section of the [Dashboard](https://cirrus.app47.com).

## How to use Enchilada

Enchilada is simple: there is a sample Excel file in the `etc/` directory. This file has 6 columns: name, email, group, auto-approve flag, expiration duration for a temporary invitation password, and an optional invitation message. Simply fill this file in with user data -- you can put as many rows containing user data as you need. 

Next, obtain your App47 Account Management API token. You can find this in the Account section of the App47 Dashboard -- you should see an API tab. In that tab, you'll find a token (it'll look something like ZSUWSDOtxOdqpzJ9u2A4QIg; that is, it'll be a random sequence of characters).

With your Excel file and token handy, you can then add users by simply typing at the command line:

`ruby whole_enchilada.rb -f <path_to_your_excel_file> -t <your_api_token>`

You might see some warnings in the output pertaining to your Excel file (especially if you reuse the sample one) to the effect of "WARN may not be a valid OLE2 structured storage file" -- you can safely ignore them. 

If you have any issues, please feel free to contact App47 support at support AT app47.com.

### Limitations

Currently, Users are not associated to existing Apps. You can do all of this within the App47 Application (either via individual users or via groups). Nevertheless, if you do require this feature within Enchilada, please feel free to contact us.

## Further Information 

For more details about our API, the various objects in our system, or about us in general, see the [App47 wiki](http://www.app47.com/wiki/doku.php) or check out our [YouTube Channel](https://www.youtube.com/user/App47Videos).

## Requirements

* Ruby 1.9.3 
* Bundler 

### Working with Bundler and RVM

This project manages Ruby versions via [RVM](http://rvm.beginrescueend.com/) and manages dependencies via [Bundler](http://gembundler.com/). 

If you don't already have Ruby 1.9.3 installed, you might want to first [install RVM](http://rvm.beginrescueend.com/rvm/install/) and then install Ruby 1.9.3 ([version 1.9.3-p547](http://rvm.beginrescueend.com/interpreters/ruby/)) via RVM. You'll now notice that this project contains a .rvmc file, which is executed upon opening the project's root directory in a terminal (and IDE's like RubyMine). The .rvmc file simply states `rvm ruby-1.9.3` which tells RVM to ensure the Ruby version to use for this project is 1.9.3. 

To set up this project's dependencies, which are defined in the file, `Gemfile`, you should first run

        $ bundle install --path vendor

Please note, your Ruby 1.9.3 version might need bundler installed:

        $ gem install bundler

# License

The MIT License

Copyright (c) 2011 App47, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE

