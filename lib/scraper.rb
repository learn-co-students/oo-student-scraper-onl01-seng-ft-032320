require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #binding.pry
    student_info = []
    doc = Nokogiri::HTML(open(index_url))
    
      #doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
      
      card =  doc.css(".student-card a")
        card.each do |student|
             name = student.css(".student-name").text 
             location = student.css(".student-location").text 
             pro_url = student.attr("href")
      
      students = {
      :name => name, 
      :location => location, 
      :profile_url => pro_url}
      student_info << students
    end 
      
    
    student_info
  end

  def self.scrape_profile_page(profile_url)
    
    students = {}
    doc = Nokogiri::HTML(open(profile_url))
    doc.css("div.main-wrapper.profile .social-icon-container a").each do |link| 
      if link.attribute("href").value.include?("twitter")
        students[:twitter] = link.attribute("href").value
        
      elsif link.attribute("href").value.include?("linkedin")
      students[:linkedin] = link.attribute("href").value
        
      elsif link.attribute("href").value.include?("github")
      students[:github] = link.attribute("href").value
      
      else 
      students[:blog] = link.attribute("href").value
    end
  end
   
  students[:profile_quote] = doc.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
  students[:bio] = doc.css("div.main-wrapper.profile .description-holder p").text
  students
  end

end
#students_social[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote").text
#students_social[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p").text
#container  doc.css("div.student-card")
#name doc.css("h4.student-name").text

#location doc.css("p.student-location").text

#url 

# #if link.include?("linkedin")
#       students_social[:linkedin] = link 
#     elsif link.include?("twitter")
#       students_social[:twitter] = link 
#     elsif link.include?("github") not working?why!
#       students_social[:github] = link 
#     else 
#       students_social[:blog] = link 
#       end
#     end 
#     #students_social[:profile_quote] = doc.css(".profile-quote").text 
#     #students_social[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text 
#     students_social