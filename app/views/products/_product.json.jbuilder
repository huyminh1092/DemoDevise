json.extract! product, :id, :name, :price, :quantity, :description, :content, :created_at, :updated_at
json.url product_url(product, format: :json)
