
require 'nokogiri'
require 'open-uri'
require 'pry'

class Reddit

  def initialize 
    html = open('http://reddit.com')
    @nokogiri_doc = Nokogiri::HTML(html)
    @articles = {}
  end

  def sub_reddit(subreddit)
    url = 'http://reddit.com/r/' + subreddit
    html = open(url)
    @doc == Nokogiri::HTML(html)
  end

  def scrape_subreddit_article
    @doc.css("a.title.may-blank").each do |subreddit_articles|
      title = subreddit_articles.text
      link = subreddit_articles.attr("href")
      @subreddit_articles[title] = link
    end
    @subreddit_articles
  end

  def random_sub_article 
    @subreddit_rand = scrape_article.to_a.sample
    @sub_rand_a = "#{@subreddit_rand[0]}"
    @sub_rand_l = "#{@subreddit_rand[1]}"
    @sub_rand_a
  end

  def r_sub_link 
   @sub_rand_l.to_s
  end


  def scrape_article
    @nokogiri_doc.css("a.title.may-blank").each do |article|
      title = article.text
      link = article.attr("href")
      @articles[title] = link
    end
    @articles
  end

  def random_article 
    @rand = scrape_article.to_a.sample
   @rand_a = "#{@rand[0]}"
   @rand_l = "#{@rand[1]}"
   @rand_a
  end

 def r_link 
   @rand_l.to_s
end


end#ends class 





