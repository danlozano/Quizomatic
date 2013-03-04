class AddColumnsToStudent < ActiveRecord::Migration
  def change
  	add_column :students, :name, :string
  	add_column :students, :classroom_id, :integer
  	add_column :students, :teacher_id, :integer
  end
end
