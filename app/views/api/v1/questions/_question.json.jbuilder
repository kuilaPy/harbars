json.extract! question, :id, :product_id, :user_id, :content, :created_at, :updated_at
json.url question_url(question, format: :json)
