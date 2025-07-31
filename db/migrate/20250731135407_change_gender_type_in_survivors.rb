class ChangeGenderTypeInSurvivors < ActiveRecord::Migration[8.0]
  def change
    change_column :survivors, :gender, :integer
  end
end
