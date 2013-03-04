class AddColumnsToAdmin < ActiveRecord::Migration
  
  def change
    
    add_column :admins, :name, :string
    add_column :admins, :student_id, :integer

	end

end
