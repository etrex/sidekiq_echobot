class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :channel_id
      t.string :user_id
      t.string :type
      t.string :message
      t.string :reply_token

      t.timestamps
    end
  end
end
