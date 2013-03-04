class FixQuizResultsString < ActiveRecord::Migration
  
  def change
    remove_column :quiz_results, :ocurrence
    add_column :quiz_results, :ocurrence, :integer
  end

end
