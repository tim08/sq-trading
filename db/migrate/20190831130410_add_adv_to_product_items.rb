class AddAdvToProductItems < ActiveRecord::Migration[5.1]
  def change
    add_column :product_items, :adv, :boolean, default: false
  end
end
