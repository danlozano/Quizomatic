class CreateQuestionResults < ActiveRecord::Migration
  def change
    create_table :question_results do |t|
      t.string :answer_a
      t.string :answer_b
      t.string :answer_c
      t.string :answer_d
      t.integer :question_id
      t.integer :quiz_result_id

      t.timestamps
    end
  end
end
