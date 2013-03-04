class CreateQuizResults < ActiveRecord::Migration
  def change
    create_table :quiz_results do |t|
      t.string :ocurrence
      t.boolean :published
      t.datetime :date
      t.integer :grade
      t.integer :student_id
      t.integer :quiz_id

      t.timestamps
    end
  end
end
