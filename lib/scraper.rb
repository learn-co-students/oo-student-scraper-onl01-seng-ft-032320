require 'open-uri'
require 'pry'

class Scraper
  
  @students = []

  def self.scrape_index_page(index_url)
    info = Nokogiri::HTML(open(index_url))
    info.css("div.student-card").each do |student|
      
      details = {}
      
      details[:name] = student.css("h4.student-name").text
      details[:location] = student.css("p.student-location").text
      details[:profile_url] = student.css("a").attribute("href").value
      
      @students << details
    end
    
    @students
    
  end

  def self.scrape_profile_page(profile_url)
    
    @links = {}
    
    info = Nokogiri::HTML(open(profile_url))
    
    info.css("div.social-icon-container a").each do |icon|
      if icon.attribute("href").value.include?("twitter")
        @links[:twitter] = icon.attribute("href").value 
      elsif icon.attribute("href").value.include?("linkedin")
        @links[:linkedin] = icon.attribute("href").value 
      elsif icon.attribute("href").value.include?("github")
        @links[:github] = icon.attribute("href").value
      else
        @links[:blog] = icon.attribute("href").value 
      end
    end
    
    @links[:profile_quote] = info.css("div.profile-quote").text
    @links[:bio] = info.css("div.description-holder p").text
    
    @links
    
  end

end

