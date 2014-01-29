class UserMailer < ActionMailer::Base
  default from: "tim@gitly.co"

  def validate_user(user)
  	@user = user

  	mail(to: @user.email, subject: "Validate your email address")
  end
end
