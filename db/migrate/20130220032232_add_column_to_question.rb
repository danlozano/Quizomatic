class AddColumnToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :correct, :string
  end
end
