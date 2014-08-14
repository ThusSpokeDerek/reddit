require 'bundler' #require bundler
Bundler.require #require everything in bundler in gemfile
require 'pry'
require_relative 'lib/red.rb'


get '/' do
  @nokogiri_doc = Reddit.new 
  erb :index # This tells your program to use the html associated with the index.erb file in your browser.
end
