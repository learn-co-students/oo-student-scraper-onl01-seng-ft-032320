class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def initialize(student_hash)
    self.send("name=", student_hash[:name])
    self.send("location=", student_hash[:location])
    self.send("profile_url=", student_hash[:profile_url])
    save
  end

def save
  @@all << self
end

 def self.create_from_collection(students_array)
    students_array.each do |student_hash|
      student_hash = Student.new(student_hash)
    end

  end

 def add_student_attributes(hash_browns) #hash for student
    self.send("twitter=", hash_browns[:twitter])
    self.send("linkedin=", hash_browns[:linkedin])
    self.send("github=", hash_browns[:github])
    self.send("blog=", hash_browns[:blog])
    self.send("profile_quote=", hash_browns[:profile_quote])
    self.send("bio=", hash_browns[:bio])
  end

 def self.all
    @@all
  end


end
