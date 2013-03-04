class AddFixToQuizResults < ActiveRecord::Migration
  def change
    remove_column :quiz_results, :grade
    add_column :quiz_results, :grade, :float
  end
end
