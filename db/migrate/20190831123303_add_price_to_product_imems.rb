class AddPriceToProductImems < ActiveRecord::Migration[5.1]
  def change
    add_column :product_items, :price, :integer
  end
end
