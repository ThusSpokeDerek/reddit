require 'bundler' #require bundler
Bundler.require #require everything in bundler in gemfile
require './lib/emailer'
require './lib/scraper'


get '/' do
  erb :index # This tells your program to use the html associated with the index.erb file in your browser.
end
