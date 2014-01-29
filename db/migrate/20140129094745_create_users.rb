class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.boolean :verified, default: false
      t.boolean :active, default: false
      t.string :auth_token

      t.timestamps
    end
    add_index :users, :email, :unique => true
  end
end
