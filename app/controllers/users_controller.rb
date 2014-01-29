class UsersController < ApplicationController
	def validate
		@user = User.find_by_auth_token(params[:auth_token])

		if @user
			@user.verified = true
			@user.active = true
			@user.save
		end
	end

	def unsubscribe
		@user = User.find_by_auth_token(params[:auth_token])

		if @user
			@user.active = false
			@user.save
		end
	end
end
