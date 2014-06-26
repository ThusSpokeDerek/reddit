require 'nokogiri'
require 'mailgun'
require './lib/scraper.rb'
require './lib/emailer.rb'

task :check_tweet_time do
  #new instance of scraper class
  @scraper = Scraper.new("https://twitter.com/jongrover")
  #take time attribute and convert it from string of epoch time to Ruby time object
  normal_tweeted_time = Time.at(@scraper.tweet_time.to_i)
  #if ruby time object is less than 10 minutes ago
  if normal_tweeted_time > Time.now - 10*60
    #instatiate new instance of Emailer
    @emailer = Emailer.new
    #call the send_email method on that instance
    @emailer.send_email
  else  
    puts "No new tweets"
  end
end
