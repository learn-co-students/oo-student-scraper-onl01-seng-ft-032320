require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css(".student-card a")
    student_cards.collect do |element|
      {:name => element.css(".student-name").text ,
        :location => element.css(".student-location").text,
        :profile_url => element.attr('href')
      }
end
end

def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    hash_slinging_slasher = {}  #The shash wringing...the trash thinging... mash flinging.. the flash springing, bringing the crash thinging...the....  (I hope noone reads my stupid notes)
   social = doc.css(".vitals-container .social-icon-container a")
  social.each do |value|
     if value.attr('href').include?("twitter")
       hash_slinging_slasher[:twitter] = value.attr('href')
    elsif value.attr('href').include?("linkedin")
      hash_slinging_slasher[:linkedin] = value.attr('href')
       elsif value.attr('href').include?("github")
       hash_slinging_slasher[:github] = value.attr('href')
       elsif value.attr('href').end_with?("com/")
      hash_slinging_slasher[:blog] = value.attr('href')
     end
      end
   hash_slinging_slasher[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      hash_slinging_slasher[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text

  hash_slinging_slasher
  end

end
