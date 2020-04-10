require 'open-uri'
require 'pry'

#Using this to simply scrape then pass along to student
class Scraper

  #passes in a url tht we can scrape from w/ nokogiri
  def self.scrape_index_page(index_url)
    students = [] #sets array to be returned later

    #takes in html of passed in URL
    doc = Nokogiri::HTML(open(index_url))
    #gets each student card so that we can pull from it
    student = doc.css("div.student-card")
    
    #for each student card, pass in name / location / profile_url into the array of hashes
    student.each do |s|
    students << {
        :name => s.css(".card-text-container h4.student-name").children[0].text,
        :location => s.css(".card-text-container p.student-location").children[0].text,
        :profile_url => s.css("a").attribute("href").value }
    end
    students
  end

  #passes in url that we can scrape 
  def self.scrape_profile_page(profile_url)

  #gets html of url
  doc = Nokogiri::HTML(open(profile_url))

  #gets all links
  links = doc.css('a')
  #gets all uniq hrefs from links and deletes if blank or if does not contain .com
  hrefs = links.map{|link| link.attribute('href').to_s}.uniq.sort.delete_if{|href| href.empty? || !href.include?(".com")}
  
  #creates profile hash
  profile = {}

  #assigns profile quote + bio text to hash
  profile[:profile_quote] = doc.css("div.profile-quote").text
  profile[:bio] = doc.css("div.description-holder p").text

  #goes through each link and adds k/v when necessary
  hrefs.each do |h|
    if h.include?("twitter")
      profile[:twitter] = h
    elsif h.include?("linkedin")
      profile[:linkedin] = h
    elsif h.include?("github")
      profile[:github] = h
    else  
      profile[:blog] = h
    end
    end
    profile
  end

end

