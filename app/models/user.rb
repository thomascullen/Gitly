class User < ActiveRecord::Base
	has_many :subscriptions
	has_many :categories, through: :subscriptions

	def has_updates?
		count = 0
		categories.each {|category| count = count + category.projects.count}
		count > 0 ? true : false
	end
end
