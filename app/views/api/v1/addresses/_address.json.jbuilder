json.extract! address, :id, :user_id, :address_line_1, :address_line_2, :city, :state, :zip_code, :country, :address_type, :created_at, :updated_at
json.url address_url(address, format: :json)
