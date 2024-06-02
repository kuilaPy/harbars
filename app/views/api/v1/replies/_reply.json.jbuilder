json.extract! reply, :id, :question_id, :user_id, :content, :created_at, :updated_at
json.url reply_url(reply, format: :json)
