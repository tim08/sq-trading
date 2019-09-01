json.extract! product_item, :id, :player_id, :product_id, :number, :created_at, :updated_at
json.url product_item_url(product_item, format: :json)
