class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :title
      t.datetime :stdate
      t.datetime :enddate
      t.boolean :final
      t.integer :teacher_id

      t.timestamps
    end
  end
end
