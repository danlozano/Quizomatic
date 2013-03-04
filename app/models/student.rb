class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :classroom
  belongs_to :school
  has_and_belongs_to_many :parents
  has_many :quiz_results

  accepts_nested_attributes_for :parents

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :classroom_id, :school_id, :name, :parents_attributes
  # attr_accessible :title, :body
end
