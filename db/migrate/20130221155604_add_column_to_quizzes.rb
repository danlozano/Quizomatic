class AddColumnToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :published, :boolean
    remove_column :quizzes, :final
  end
end
