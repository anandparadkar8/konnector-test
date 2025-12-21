class CreateSchools < ActiveRecord::Migration[8.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
