class Category < ActiveRecord::Base
	has_many :subscriptions
	has_many :users, through: :subscriptions

	has_many :projects
end
