class CreateStudentsParents < ActiveRecord::Migration
  def change
    create_table :students_parents do |t|
      t.integer :student_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
