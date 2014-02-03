class SubscriptionsController < ApplicationController
	def new
		@categories = Category.all.order('name desc')
		@user = User.new
	end

	def create
		@user = User.find_by_email(params[:email]) || User.create(:email => params[:email], :auth_token => SecureRandom.hex(32))
		
		if @user
			@user.subscriptions.destroy_all

			params[:categories].each do |selected_category_id|
				category = Category.find(selected_category_id)
				@user.subscriptions.create(:category => category, :active => true)
			end

			UserMailer.notify_admin(@user, "New subscriber: #{@user.email}").deliver
		end

		send_activation_mail(@user) if !@user.active
	end

	def edit
		@user = User.find_by_auth_token(params[:id])
		unless @user
			redirect_to root_path
		end
	end

	def update
		@user = User.find_by_auth_token(params[:auth_token])

		if @user
			@user.subscriptions.destroy_all

			params[:categories].each do |selected_category_id|
				category = Category.find(selected_category_id)
				@user.subscriptions.create(:category => category, :active => true)
			end
		end

		UserMailer.notify_admin(@user, "Updated subscriber: #{@user.email}").deliver
	end

	private
	def send_activation_mail(user)
		logger.warn "Send activation email to #{user.email}"
		UserMailer.validate_user(user).deliver
	end
end
