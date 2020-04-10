require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
     
     results = Nokogiri::HTML(open(index_url))
 
     students = []
     
     results.css("div.student-card").each do |student|
      student_info= 
      {:name=> student.css("h4.student-name").text,
      :location=> student.css("p.student-location").text,
      :profile_url=> student.css("a").attribute("href").value}
          students<< student_info
        end
      students
  end

  def self.scrape_profile_page(profile_url)

    profile = {}
    
    url = Nokogiri::HTML(open(profile_url))

    url.css('div.social-icon-container a').collect {|item| item.attribute("href").value}.each do |link|
      if link.include?("github")
        profile[:github] = link
      elsif link.include?("linkedin")
        profile[:linkedin] = link
      elsif link.include?("twitter")
        profile[:twitter]= link
      elsif link.include?(".com")
        profile[:blog]= link
      end
    end
    profile[:profile_quote]= url.css('div.profile-quote').text
    profile[:bio]= url.css('div.description-holder p').text
    profile
  end
end


puts Scraper.scrape_profile_page("https://learn-co-curriculum.github.io/student-scraper-test-page/students/james-novak.html")



#bio = url.css('div.description-holder p').text
#auote      url.css('div.profile-quote').text