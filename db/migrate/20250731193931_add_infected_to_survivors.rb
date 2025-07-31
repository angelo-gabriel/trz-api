class AddInfectedToSurvivors < ActiveRecord::Migration[8.0]
  def change
    add_column :survivors, :infected, :boolean
  end
end
