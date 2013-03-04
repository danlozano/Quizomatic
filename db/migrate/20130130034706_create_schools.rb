class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :location
      t.string :picture

      t.timestamps
    end
  end
end
