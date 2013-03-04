module QuizResultsHelper

  def appropiate_answer(question_result, letter)
    method = "answer_" + letter
    question_result.question.send(method)
  end

end
