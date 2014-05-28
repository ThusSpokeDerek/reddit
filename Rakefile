require 'nokogiri'
require 'open-uri'
require 'mailgun'
require './lib/scraping.rb'
require './lib/messaging.rb'


task :check_tweet_time do
    #new instance of twitter class
  @twitter_nokogiri = TwitterNokogiri.new("https://twitter.com/vicfriedman")
  #take time attribute and convert it from string of epoch time to Ruby time object
  normal_tweeted_time = Time.at(@twitter_nokogiri.tweet_time.to_i)
  #if ruby time object is less than 10 minutes ago
  if normal_tweeted_time > Time.now - 10*60
    #instatiate new instance of SendingTweets
    @sending_emails = SendingTweets.new
    #call the email_tweets method on that instance
    @sending_emails.email_tweets
  else  
    puts "No new tweets"
  end
end
