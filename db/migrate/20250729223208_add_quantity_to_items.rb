class AddQuantityToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :quantity, :integer, default: 0, null: false
  end
end
