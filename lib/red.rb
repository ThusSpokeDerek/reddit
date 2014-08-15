
require 'nokogiri'
require 'open-uri'

class Reddit

  def initialize 
    html = open('http://reddit.com')
    @nokogiri_doc = Nokogiri::HTML(html)
    @articles = {}
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
    rand = scrape_article.to_a.sample
   "#{rand[0]} --- #{rand[1]}"
  end

end


