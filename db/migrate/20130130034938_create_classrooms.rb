class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.string :name
      t.string :grade
      t.integer :school_id

      t.timestamps
    end
  end
end
