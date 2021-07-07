require 'open-uri'
require 'pry'
class Scraper
  
  def self.scrape_index_page(index_url)
    students = []
    
    html = open(index_url)
    index_page = Nokogiri::HTML(html)
    
    index_page.css('div.student-card').each do |student|
      student_info = {}
      student_info[:name] = student.css('h4.student-name').text
      student_info[:location] = student.css('p.student-location').text
      student_info[:profile_url] = student.css('a').attribute('href').value
      students << student_info
    end
      students
  end

  def self.scrape_profile_page(profile_url)
    profile_info = {}

    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)
    #social media links
    profile_page.css('div.main-wrapper.profile .social-icon-container a').each do |media|
      if media.attribute('href').value.include? ('twitter')
        profile_info[:twitter] = media.attribute('href').value
      elsif media.attribute('href').value.include? ('linkedin')
        profile_info[:linkedin] = media.attribute('href').value
      elsif media.attribute('href').value.include? ('github')
        profile_info[:github] = media.attribute('href').value
      else 
        profile_info[:blog] = media.attribute('href').value
      end
    end

  #profile quote
    profile_info[:profile_quote] = profile_page.css('div.main-wrapper.profile .vitals-text-container .profile-quote').text

  #bio
  
    profile_info[:bio] = profile_page.css('div.main-wrapper.profile .description-holder p').text
    
    profile_info  
  end

end