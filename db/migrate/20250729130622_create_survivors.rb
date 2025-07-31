class CreateSurvivors < ActiveRecord::Migration[8.0]
  def change
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.integer:gender
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
