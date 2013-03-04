class AddFinalFix < ActiveRecord::Migration
  def change
    remove_column :quiz_results, :grade
    add_column :quiz_results, :grade, :decimal
  end
end

