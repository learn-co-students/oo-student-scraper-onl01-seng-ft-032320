require 'open-uri'
require 'pry'

class Scraper
  
  
  def self.scrape_index_page(index_url)
    
    students = []
    
    html = Nokogiri::HTML(open(index_url)) # Grabs the HTML 
    
    html.css(".student-card").collect do |student|
      hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students << hash 
    end
    students
    
  end

  def self.scrape_profile_page(profile_url)
    student = {}
    
    html = Nokogiri::HTML(open(profile_url))
    container = html.css(".social-icon-container a").collect{|icon|
    icon.attribute("href").value}
    container.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link 
      elsif link.include?("github")
        student[:github] = link 
      elsif link.include?(".com")
        student[:blog] = link
      end
    end
      student[:profile_quote] = html.css(".profile-quote").text
      student[:bio] = html.css("div.description-holder p").text
      student
  end

end

