require 'open-uri'
require 'pry'

class Scraper

  #### Class Methods ####
  def self.scrape_index_page(index_url)
    students_array = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    students.each do |student_obj|
      students_array << {
        :name => student_obj.css("a .student-name").text,
        :location => student_obj.css("a .student-location").text,
        :profile_url => student_obj.css("a").attribute("href").value}
    end
    students_array
  end

  def self.scrape_profile_page(profile_url)
    student_hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    student_social_info = doc.css(".social-icon-container a")

    student_social_info.each do |info_obj|
      # twitter, linkedin, github and blog checks
      if info_obj.attribute("href").value.include?("twitter")
        student_hash[:twitter] = info_obj.attribute("href").value
      elsif info_obj.attribute("href").value.include?("linkedin")
        student_hash[:linkedin] = info_obj.attribute("href").value
      elsif info_obj.attribute("href").value.include?("github")
        student_hash[:github] = info_obj.attribute("href").value
      else
        student_hash[:blog] = info_obj.attribute("href").value
      end
    end

    student_hash[:profile_quote] = doc.css(".profile-quote").text
    student_hash[:bio] = doc.css(".bio-content p").text

    student_hash
  end

end
