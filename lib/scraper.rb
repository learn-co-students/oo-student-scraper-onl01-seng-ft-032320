require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)

    array = []
    html = open(index_url)
    index = Nokogiri::HTML(html)
    index.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student_card|
        name = student_card.css(".student-name").text
        location = student_card.css(".student-location").text
        profile_url = student_card.attr("href")
        array << {:name => name, :location => location, :profile_url => profile_url}
    # binding.pry
      end
    end
    array
end




  def self.scrape_profile_page(profile_url)
    student_profile = {}

   html = open(profile_url)
   profile = Nokogiri::HTML(html)



   profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
     if social.attribute("href").value.include?("twitter")
       student_profile[:twitter] = social.attribute("href").value
     elsif social.attribute("href").value.include?("linkedin")
       student_profile[:linkedin] = social.attribute("href").value
     elsif social.attribute("href").value.include?("github")
       student_profile[:github] = social.attribute("href").value
     else
       student_profile[:blog] = social.attribute("href").value
     end
   end

   student_profile[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
   student_profile[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text

   student_profile
 end
end
