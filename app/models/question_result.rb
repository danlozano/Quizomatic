class QuestionResult < ActiveRecord::Base

  attr_accessible :answer, :question_id, :quiz_result_id

  belongs_to :quiz_result
  belongs_to :question

  def correct?
    self.question.correct == self.answer
  end

end
