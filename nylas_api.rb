
api =
nylas_token = api.authenticate(
  name: auth_hash[:info][:name],
  email_address: auth_hash[:info][:email],
  provider: :gmail,
  settings: {
    google_client_id: ENV['GOOGLE_CLIENT_ID'],
    google_client_secret: ENV['GOOGLE_CLIENT_SECRET'],
    google_refresh_token: auth_hash[:credentials][:refresh_token]
  }
)