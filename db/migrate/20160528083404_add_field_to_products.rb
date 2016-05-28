class AddFieldToProducts < ActiveRecord::Migration
  def change
    add_column :products, :priority, :string
  end
end
