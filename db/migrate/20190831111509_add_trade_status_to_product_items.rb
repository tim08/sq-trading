class AddTradeStatusToProductItems < ActiveRecord::Migration[5.1]
  def change
    add_column :product_items, :trade_status, :boolean, default: false
  end
end
