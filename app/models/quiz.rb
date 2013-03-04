class Quiz < ActiveRecord::Base

  attr_accessible :enddate, :published, :stdate, :teacher_id, :title, :ocurrences, :questions_attributes

  has_many :questions, :dependent => :destroy
  has_many :quiz_results, :dependent => :destroy
  belongs_to :teacher

  accepts_nested_attributes_for :questions, :allow_destroy => :true 

  def self.TakeableQuizzes(available_quizzes, quiz_results)
    takeable_quizzes = []
    available_quizzes.each do |quiz|
      if Quiz.QuizRules(quiz, quiz_results)
        takeable_quizzes << quiz
      end
    end
    return takeable_quizzes
  end

  def self.QuizRules(quiz, quiz_results)
    quiz.published == true && quiz.ocurrences > Quiz.getMaxQuizResultOcurrence(quiz, quiz_results) && Time.now.between?(quiz.stdate, quiz.enddate)
  end

  def self.getMaxQuizResultOcurrence(quiz, quiz_results)
    maxOcurrence = 0
    quiz_results.each do |quiz_result|
      if quiz_result.quiz_id == quiz.id && quiz_result.published == true
        if quiz_result.ocurrence > maxOcurrence
          maxOcurrence = quiz_result.ocurrence
        end
      end
    end
    maxOcurrence
  end

end
