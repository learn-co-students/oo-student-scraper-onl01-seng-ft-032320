class Student

  #### Attributes ####
  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []


  #### Instance Methods ####
  def initialize(student_hash)
    student_hash.each do |k,v|
      self.send("#{k}=", v)
    end
    @@all << self
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k,v|
      self.send("#{k}=", v)
    end
  end


  #### Class Methods ####
  def self.create_from_collection(students_array)
    # index = Scraper.scrape_index_page("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")
    students_array.each do |student_hash|
      self.new(student_hash)
    end
  end

  def self.all
    @@all
  end
end
