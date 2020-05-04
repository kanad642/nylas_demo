class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :image
      t.string :email
      t.string :connected_email
      t.string :refresh_token
      t.datetime :email_connection_date
      t.string :uid
      t.string :email_provider
      t.string :nylas_token
      t.string :nylas_account_id

      t.timestamps
    end
  end
end
