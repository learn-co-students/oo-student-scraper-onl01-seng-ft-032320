require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students_array = []
    data = Nokogiri::HTML(open(index_url))
    data.css(".student-card").each do |card|
      hash ={}
      hash[:name] = card.css(".student-name").text
      hash[:location] = card.css(".student-location").text
      hash[:profile_url] = card.children[1].attributes["href"].value
      students_array << hash
    end    
    students_array
  end

  def self.scrape_profile_page(profile_url)
    student_data = Nokogiri::HTML(open(profile_url))
    social_media = student_data.css('.social-icon-container a')
    student_hash = {}
    social_media.each do | link|
      url = link.attributes["href"].value
      url.slice!("http://")
      url.slice!("https://")
      url.slice!("www")
      key = "blog"
      if url[/[^.com]+/] == "twitter" || url[/[^.com]+/] == "github" || url[/[^.com]+/] == "linkedin"
        key = url[/[^.com]+/] 
      end
      student_hash[:"#{key}"] = link.attributes["href"].value
    end
  
    student_hash[:profile_quote] = student_data.css(".profile-quote").text
    student_hash[:bio] = student_data.css('.description-holder p').text

    student_hash
  end

end