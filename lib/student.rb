class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  #creates new student via hash thae we passed in via scraper
  def initialize(student_hash)
    #for each student in hash, create a k/v pair via mass asign (.send)
    student_hash.each {|k,v| self.send(("#{k}="), v)}
    self.save
  end

  def self.create_from_collection(students_array)
    students_array.each {|s| s = self.new(s)}
  end

  #adds additional attributes to student instance via mass assign (.send)
  def add_student_attributes(attributes_hash)
    attributes_hash.each {|k,v| self.send(("#{k}="), v)}
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

end

