class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :url
      t.text :description
      t.integer :watchers
      t.integer :stargazers
      t.belongs_to :category

      t.timestamps
    end
  end
end
