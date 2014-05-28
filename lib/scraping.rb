require 'open-uri'

 class TwitterNokogiri

  def initialize(doc)
    @doc = Nokogiri::HTML(open("#{doc}"))
    @tweet_text  = self.get_tweets_text
    @tweet_time = self.get_tweets_time
  end

  def get_tweets_text # Search for nodes by css
    tweet_text = @doc.css("p.js-tweet-text").first.text
    tweet_text
  end

  def get_tweets_time
   tweeted_time = @doc.css("small.time").first.children.children.first.attributes["data-time"].value
   tweeted_time
  end

  def tweet_text
    @tweet_text
  end

  def tweet_text=(text)
    @tweet_text = text
  end

  def tweet_time
    @tweet_time
  end

  def tweet_time=(time)
    @tweet_time = time
  end

  def doc
    @doc
  end

  def doc=(doc)
    @doc = doc
  end

end