#we're going to set up our Ruby application to deploy so that our backend logic will run on it's own, and we'll also have the option of a pretty front end.

#To do this, we're going to use Sinatra. 
#[Sinatra](http://www.sinatrarb.com/). is a ruby gem that provides a very light-weight framework for building and deploying ruby applications. 

#we'll need to create a bunch of different files and directories, starting with `app.rb`
#this file is responsible for bundling all of the ruby logic you write and passing it to the browser.
#its the big communicator of your application

#at the top of our app.rb file we're going to need to require a bunch of stuff:
require 'bundler' #require bundler
Bundler.require #require everything in bundler in gemfile
require 'pry'

#bundler is a package for managing gems. 

#Let's go ahead and make files to copy and paste our code in from our messaging lab
#`mkdir lib`
#touch ./lib/messaging.rb 
#touch ./lib/scraping.rb

#we'll need to require these files in app.rb so that the root of our application knows the files exist

require 'bundler' #require bundler
Bundler.require #require everything in bundler in gemfile
require 'pry'
require './lib/scraping.rb'
require './lib/messaging.rb'

#let's also copy and paste our Rakefile -- we'll need to change the path to the files we're requiring
#because they're now nested in the lib directory

#Next we're going to create a Gemfile. A gemfile is basically a Ruby way to manage all the gems used in an application, and keep versions stable within projects
#If a new version of Nokogiri comes out and a lot is changed, we don't want our entire app to break just because we wrote it with an older version

source 'https://rubygems.org'

gem 'sinatra'

gem 'shotgun'

gem 'rake'

gem 'nokogiri'

gem 'pry'

gem 'mailgun'

#Once the Gemfile has been created, we'll enter 'bundle install' in terminal
#This will create a Gemfile.lock file which locks in all the proper versions of your gems for this particular project.

#so now that we have all our gems set up and our previously written ruby code in the application.
#we can work on putting all of this together in sinatra
# becuase app.rb manages the logic that takes your ruby code and passes it to the browser
#it has special language for managing the routes of your application
#aka, the url's that you use to go to a website

get '/' do
  erb :index
end

#the get method is telling the root directory to go to an .html.erb file called 'index' 
#the .erb extension allows us to write ruby in the browser
#we'll create that now and put it in a 'views' directory and add some simple HTML to start
`<h1> heyyy! </h1>`

#we're using the shotgun gem to run localhost to view our work in the browser.
#localhost is the internal server of your computer. It's what we run to execute our code and see how it would work on a remote server
#`shotgun app.rb` will start up localhost and then in the browser go to `localhost:` and the port shotgun tells us.
#shotgun is a cool and useful gem because it leaves our server running and reloads any changes to our code without us having to do it manually

#So because we used MailGun for this project, we'll need to set up SMTP configurations.
#SMTP stands for Simple Mail Transfer Protocol. Just like HTTP is the transfer protocol for the browser, SMTP is for sending emails.
#we'll create a 'config.ru' file

require './app'
run Sinatra::Application

Mail.defaults do
  delivery_method :smtp, {
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :domain => 'localhost:9393',
    :user_name => 'postmaster@sandbox9e40982438de4c218c126056aa8f25ea.mailgun.org',
    :password =>  '7u2yp3x6t6w9',
    :authentication => 'plain',
    :enable_starttls_auto => true
  }
end

#here we specified the email address from mailgun and the password that goes along with the account
#we're setting the domain to localhost because we're just testing this locally (that'll change when we deploy)

#If we wanted to display the most recent tweet in the browser, we'll need to put a little more logic in `get '/'` in app.rb
#Our index.html.erb doesn't have access to our classes in scraping.rb and messaging.rb without us telling it

get '/' do
  @twitter_nokogiri = TwitterNokogiri.new("https://www.twitter.com/vicfriedman")
  erb :index #this tells your program to use the html associated with the index.html.erb file in your browser
end 

#and now in index.html.erb....
`<h1> MY APP </h1>`
`<p> This tweet: <%= @twitter_nokogiri.tweet_text %> was tweeted at <%= Time.at(@twitter_nokogiri.tweet_time.to_i) %>`

# the `<%= %> are called erb tags. it's how we can embed ruby right into the HTML. 
#our browser will evuluate the ruby code and then write the return value as part of the HTML
# Now to see this in the brower if we refesh, the most recent tweet.

#we can also check our rake task by entering `rake check_tweet_time`

