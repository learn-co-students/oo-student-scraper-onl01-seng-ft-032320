require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    profiles = doc.css(".student-card")
    profiles.each do |profile|
      student = {}
      student[:name] = profile.css(".student-name").text
      student[:location] = profile.css(".student-location").text 
      student[:profile_url] = profile.css("a").attribute("href").value
      students << student
    end 
    students 
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    student = {}
    social_links = profile.css(".social-icon-container a").map{|link| link.attribute("href").value}
    social_links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?("twitter")
        student[:twitter] = link
      else
        student[:blog] = link
      end
    end 
    student[:profile_quote] = profile.css(".vitals-text-container .profile-quote").text
    student[:bio] = profile.css(".description-holder p").text
    student 
  end

end

