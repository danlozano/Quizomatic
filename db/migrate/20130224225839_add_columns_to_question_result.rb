class AddColumnsToQuestionResult < ActiveRecord::Migration
  def change
    remove_column :question_results, :answer_a
    remove_column :question_results, :answer_b
    remove_column :question_results, :answer_c
    remove_column :question_results, :answer_d

    add_column :question_results, :answer, :string
  end
end
