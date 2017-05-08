require 'sendgrid-ruby'
include SendGrid
require 'open-uri'
require 'mechanize'
require 'nokogiri'
require 'dotenv'
Dotenv.load

task :send_email  do
	agent = Mechanize.new
	page = agent.get("http://mashable.com/")

	articles = []

	page.search(".flat").each do |currentResult|
		if(articles.length < 5)
			article = {}
			article["title"] = currentResult.search("h1").text
			article["url"] = currentResult.search("a").map {|element| element["href"]}.compact
			article["time-created"] = DateTime.parse(currentResult.search("time").map {|element| element["datetime"]}.compact[0]).strftime("%m/%d/%Y at %I:%M%p")
			articles.push(article)
		end
	end

	email_string = ""

	articles.each do |article|
		email_string = email_string + "<a href='#{article['url'][0]}'> #{article['title']} </a> Posted: #{article['time-created']} <br>"
	end
	data = JSON.parse('{
	  "personalizations": [
	    {
	      "to": [
	        {
	          "email": "thebluecat544@gmail.com"
	        }
	      ],
	      "subject": "Mashable\'s 5 Most Recent Articles"
	    }
	  ],
	  "from": {
	    "email": "hello@mashablescraper.com",
			"name": "Mashable Scraper"
	  },
	  "content": [
	    {
	      "type": "text/html",
	      "value": "' + email_string + '"
			}
	  ]
	}')
	sg = SendGrid::API.new(api_key: ENV['SENDGRID_KEY'])
	response = sg.client.mail._("send").post(request_body: data)
end
