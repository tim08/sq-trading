class Player < ApplicationRecord
  has_many :product_items

  validates_numericality_of :currency_amount, greater_than_or_equal_to: 0
  before_create do |player|
    player.api_key = player.generate_api_key
  end

  def generate_api_key
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless Player.exists?(api_key: token)
    end
  end

end
