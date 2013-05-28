class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.string :token
      t.string :login_name

      t.timestamps
    end
  end
end
