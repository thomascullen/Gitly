class SubscriptionsController < ApplicationController
	def new
		@categories = Category.all.order('name desc')
	end
end
