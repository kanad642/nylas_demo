json.extract! user, :id, :name, :image, :email, :connected_email, :refresh_token, :email_connection_date, :uid, :email_provider, :created_at, :updated_at
json.url user_url(user, format: :json)
