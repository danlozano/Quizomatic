class AddColumnToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :ocurrences, :integer
  end
end
