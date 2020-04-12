require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    index = Nokogiri::HTML(html)
    index.css("div.student-card").each do |student| # you got to find a css selector that contains all the studens and will iterate through all of one student information a scrape what we want
      student_details = {}
      student_details[:name] = student.css("h4.student-name").text
      student_details[:location] = student.css("p.student-location").text
      profile_path = student.css("a").attribute("href").value
      student_details[:profile_url] = profile_path
      #student_details[:profile_url] = './fixtures/student-site/' + profile_path
      students << student_details
    end
    students
    #binding.pry
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile = Nokogiri::HTML(html)
    student_profile = {}

    profile.css("div.main-wrapper.profile .social-icon-container a").each { |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value # iterating over the socials container. getting the twitter url. going to need if statemnts or all i put here will trigger several times base on social links
      elsif  social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
    }

    student_profile[:profile_quote] = profile.css("div.profile-quote").text
    student_profile[:bio] = profile.css("div.description-holder p").text
    student_profile
    #binding.pry
  end

end
