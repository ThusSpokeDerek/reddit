require 'bundler' #require bundler
Bundler.require #require everything in bundler in gemfile
require 'pry'
require_relative './lib/reddit.rb'


get'/' do
  @nokogiri_doc = Reddit.new 
  @link = @nokogiri_doc.r_link
  erb :index # This tells your program to use the html associated with the index.erb file in your browser.
end


post '/results' do
  @doc = Reddit.new
  @doc.sub_reddit(params[:subreddit])
  @link = @doc.r_sub_link
  erb :results
end
