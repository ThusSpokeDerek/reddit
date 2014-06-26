require 'mailgun'

class Emailer
  Mailgun.configure do |config|
    config.api_key = 'key-6uiavyyd3nmb9adpaii04drw93y8ymq8'
    config.domain  = 'sandbox9e40982438de4c218c126056aa8f25ea.mailgun.org'
  end

  def send_email
    @scraper = Scraper.new("https://twitter.com/jongrover")
    parameters = {
      :to => "jon@flatironschool.com",
      :subject => "New Tweet!",
      :text => "Here's the tweet: #{@scraper.tweet_text}",
      :from => "postmaster@sandbox9e40982438de4c218c126056aa8f25ea.mailgun.org"
    }
    @mailgun = Mailgun()
    @mailgun.messages.send_email(parameters)
  end
end