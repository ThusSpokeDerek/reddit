require 'bundler' #require bundler
Bundler.require #require everything in bundler in gemfile
require './lib/messaging'
require './lib/scraping'
require 'pry'


get '/' do
  @twitter_nokogiri = TwitterNokogiri.new("https://www.twitter.com/vicfriedman")
  erb :index #this tells your program to use the html associated with the index.html.erb file in your browser
end 