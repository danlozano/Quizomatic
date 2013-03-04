class RemoveTableStudentsParents < ActiveRecord::Migration
  def up
    drop_table :students_parents
  end

  def down
  end
end
