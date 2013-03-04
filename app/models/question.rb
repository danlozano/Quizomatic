class Question < ActiveRecord::Base

  attr_accessible :answer_a, :answer_b, :answer_c, :answer_d, :correct, :question, :quiz_id

  belongs_to :quiz
  has_many :question_results

end
