require 'open-uri'

class Scraper

  attr_accessor :tweet_text
  attr_accessor :tweet_time
  attr_accessor :doc

  def initialize(doc)
    @doc = Nokogiri::HTML(open("#{doc}"))
    @tweet_text  = self.get_tweets_text
    @tweet_time = self.get_tweets_time
  end

  def get_tweets_text # Search for nodes by css
    tweet_text = @doc.css("p.js-tweet-text").first.text
  end

  def get_tweets_time
   tweeted_time = @doc.css(".js-short-timestamp").first.attributes["data-time"].value
  end
end