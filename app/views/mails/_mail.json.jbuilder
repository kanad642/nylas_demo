json.extract! mail, :id, :mail_id, :raw_email, :from, :mail_date, :created_at, :updated_at
json.url mail_url(mail, format: :json)
