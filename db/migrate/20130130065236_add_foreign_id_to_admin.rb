class AddForeignIdToAdmin < ActiveRecord::Migration
  def change
  	add_column :admins, :school_id, :integer
  	remove_column :admins, :student_id
  end
end
