json.array!(@stores) do |store|
  json.extract! store, :id, :user_id, :name, :category, :description, :logo, :background_image, :slug
  json.url store_url(store, format: :json)
end
