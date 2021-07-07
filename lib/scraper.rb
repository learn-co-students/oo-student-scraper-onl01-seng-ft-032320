require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  
  
  def self.scrape_index_page(index_url)
    
    students = []
    html = open(index_url)
    index = Nokogiri::HTML(html)
    index.css("div.student-card").each do |student|
      profile = {}
      profile[:name] = student.css("h4.student-name").text
      profile[:location] = student.css("p.student-location").text
      profile[:profile_url] =  student.css("a").attribute("href").value
      students << profile
          #binding.pry
    end
    students
    
  end
  
def self.scrape_profile_page(profile_url)
  attributes_hash = {}
  html = open(profile_url)
  profile = Nokogiri::HTML(html)
  profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
    
    if social.attribute("href").value.include?("twitter.com")
        attributes_hash[:twitter] = social.attribute("href").value
    elsif social.attribute("href").value.include?("linkedin")
        attributes_hash[:linkedin] = social.attribute("href").value
    elsif social.attribute("href").value.include?("github")
       attributes_hash[:github] = social.attribute("href").value
    else
      attributes_hash[:blog] = social.attribute("href").value
    end
   end

    attributes_hash[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    attributes_hash[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text

    attributes_hash
end 


end

