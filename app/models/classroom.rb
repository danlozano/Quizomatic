class Classroom < ActiveRecord::Base
  
  belongs_to :teacher
  has_many :students
  belongs_to :school

  attr_accessible :grade, :name, :school_id, :teacher_id
end
