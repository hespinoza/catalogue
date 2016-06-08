json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :price, :user_id, :store_id
  json.url product_url(product, format: :json)
end
