class RemoveClassroomFromTeacher < ActiveRecord::Migration
  def up
    remove_column :teachers, :classroom_id
  end

  def down
    add_column :teachers, :classroom_id, :integer
  end
end
