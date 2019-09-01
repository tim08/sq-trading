class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :nickname
      t.integer :currency_amount

      t.timestamps
    end
  end
end
