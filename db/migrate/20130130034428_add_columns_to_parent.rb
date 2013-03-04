class AddColumnsToParent < ActiveRecord::Migration
  def change
  	add_column :parents, :name, :string
  end
end
