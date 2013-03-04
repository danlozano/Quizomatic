class RemoveTeacherFromStudent < ActiveRecord::Migration
  def up
    remove_column :students, :teacher_id
  end

  def down
    add_column :students, :teacher_id, :integer
  end
end
