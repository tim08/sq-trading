class CreateProductItems < ActiveRecord::Migration[5.1]
  def change
    create_table :product_items do |t|
      t.references :player, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
