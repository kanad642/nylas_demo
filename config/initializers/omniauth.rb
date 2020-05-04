Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
    {
      name: 'google',
      access_type: :offline,
      approval_prompt: 'force',
      scope: ['email', 'profile', 'https://www.googleapis.com/auth/gmail.readonly'].join(', '),
      prompt: 'consent',
      image_aspect_ratio: 'square',
      image_size: 50,
      skip_jwt: 'true',
      #redirect_uri: 'https://api.nylas.com/oauth/callback',
      redirect_uri: 'http://localhost:4000/auth/google/callback'
    }
end


# scope: 'https://www.googleapis.com/auth/gmail.readonly https://www.googleapis.com/auth/gmail.send',