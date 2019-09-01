class ProductItem < ApplicationRecord
  belongs_to :player
  belongs_to :product

  validates_numericality_of :price, :greater_than_or_equal_to => 1, :allow_nil => true

  def check_available_number(user_sell_number)
    number >= user_sell_number.to_i
  end

  def split_stack(params)
    ActiveRecord::Base.transaction do
      self.update!(number: number - params[:user_sell_number].to_i, trade_status: true, price: params[:price].to_i)
      ProductItem.create(number: params[:user_sell_number].to_i, player: self.player, product: self.product)
    end
  end

  def to_advertise
    config = YAML.load_file('Config/trading_setting.yml')
    ActiveRecord::Base.transaction do
      player.update!(currency_amount: player.currency_amount - config["market"]["payment_for_advertising"])
      update_attribute(:adv, true)
    end

  end

  def self.search(params)
    product_items = where(:adv => true)
    product_items = product_items.where(product_id: params[:product_id]) if params[:product_id].present?
    product_items = product_items.where(number: params[:number]) if params[:number].present?
    product_items = product_items.where(price: params[:price]) if params[:price].present?
    product_items
  end

  def buy(customer)
    seller = self.player
    ProductItem.transaction do
      customer.update!(currency_amount: customer.currency_amount - self.price)
      seller.update!(currency_amount: seller.currency_amount + self.price)
      self.update!(price: nil, player_id: customer.id, adv: false, trade_status: false)
    end
  end
end
