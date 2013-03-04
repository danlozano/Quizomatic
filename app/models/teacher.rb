class Teacher < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :classroom
  belongs_to :school
  has_many :students
  has_many :quizzes, :dependent => :destroy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :classroom_id, :school_id, :name
  # attr_accessible :title, :body
end
