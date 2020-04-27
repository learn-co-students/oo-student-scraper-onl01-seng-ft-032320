require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    nodes = doc.css("div.student-card")
    students = nodes.collect do |student|
      {
        :name => student.css("h4.student-name").text.strip,
        :location => student.css("p.student-location").text.strip,
        :profile_url => student.css("a")[0]["href"]
      }
      
    end
    students

    
    
  end

  def self.scrape_profile_page(profile_url)
    # profile_hash initialized as an empty hash
    student_hash = {}
    
    # Provides the html for a given student profile 
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    
    social_links = doc.css(".social-icon-container a").collect do |element|
      element["href"]
    end
    
    # Add the social media links
    social_links.each do |link|
      if link.include?("twitter")
        student_hash[:twitter] = link
      elsif(link.include?("linkedin"))
        student_hash[:linkedin] = link
      elsif(link.include?("github"))
        student_hash[:github] = link
      else
        student_hash[:blog] = link
      end
    end
    
    # Add the profile quote 
    student_hash[:profile_quote] = doc.css("div.profile-quote").text.strip
    
    student_hash[:bio] = doc.css("div.description-holder p").text.strip
    
    student_hash
  end

end

