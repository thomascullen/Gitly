class Category < ActiveRecord::Base
	extend FriendlyId
  friendly_id :name, use: :slugged

	has_many :subscriptions
	has_many :users, through: :subscriptions

	has_many :projects

	def has_project_updates?

	end
end
