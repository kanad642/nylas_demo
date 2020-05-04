class CreateMails < ActiveRecord::Migration[5.0]
  def change
    create_table :mails do |t|
      t.string :mail_id
      t.text :raw_email
      t.string :from
      t.string :mail_date

      t.timestamps
    end
  end
end
