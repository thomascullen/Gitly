class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :url
      t.text :description
      t.integer :watchers
      t.integer :stargazers
      t.integer :github_id
      t.belongs_to :category

      t.timestamps
    end

    add_index :projects, :github_id, :unique => true
  end
end
