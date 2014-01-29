class SubscriptionsController < ApplicationController
	def new
		@categories = Category.all.order('name desc')
		@user = User.new
	end

	def create
		@user = User.find_by_email(params[:email]) || User.create(:email => params[:email], :auth_token => SecureRandom.hex(32))
		
		if @user
			params[:categories].each do |selected_category_id|
				category = Category.find(selected_category_id)
				@user.subscriptions.create(:category => category, :active => true)
			end
		end

		send_activation_mail(@user) if !@user.active
	end

	private
	def send_activation_mail(user)
		logger.warn "Send activation email to #{user.email}"
		UserMailer.validate_user(user).deliver
	end
end
