class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.boolean :verified
      t.boolean :active
      t.string :auth_token

      t.timestamps
    end
  end
end
