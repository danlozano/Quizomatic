class QuizResult < ActiveRecord::Base

  attr_accessible :date, :grade, :ocurrence, :published, :quiz_id, :student_id, :question_results_attributes

  has_many :question_results, :dependent => :destroy
  belongs_to :student
  belongs_to :quiz

  accepts_nested_attributes_for :question_results

  def setGrade
    correctCount = 0.0
  
    self.question_results.each do |question_result|
      if question_result.correct? 
        correctCount = correctCount + 1.0
      end
    end
    
    if correctCount == 0.0 || self.question_results.count == 0.0
      self.grade = 0.0
    else
      self.grade = ((correctCount / self.question_results.count) * 100).round(1)
    end

  end

end
