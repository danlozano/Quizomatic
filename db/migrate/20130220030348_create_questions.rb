class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.string :answer_a
      t.string :answer_b
      t.string :answer_c
      t.string :answer_d
      t.integer :quiz_id

      t.timestamps
    end
  end
end
