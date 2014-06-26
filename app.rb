require 'bundler' #require bundler
Bundler.require #require everything in bundler in gemfile
require './lib/emailer'
require './lib/scraper'

get '/' do
  scraper = Scraper.new("https://www.twitter.com/jongrover")
  @tweet = scraper.tweet_text
  @time = Time.at(scraper.tweet_time.to_i)
  erb :index # This tells your program to use the html associated with the index.erb file in your browser.
end