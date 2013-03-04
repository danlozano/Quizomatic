class School < ActiveRecord::Base
  
  has_many :classrooms
  has_many :teachers
  has_many :parents
  has_many :students
  has_one :admin

  attr_accessible :location, :name, :picture, :time_zone

end
