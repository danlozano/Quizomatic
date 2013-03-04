class AddColumnsToTeacher < ActiveRecord::Migration
  def change
  	add_column :teachers, :name, :string
  	add_column :teachers, :classroom_id, :integer
  end
end
