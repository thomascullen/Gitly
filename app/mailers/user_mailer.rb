class UserMailer < ActionMailer::Base
  default from: "Gitly <no-reply@gitly.co>"

  def validate_user(user)
  	@user = user

  	mail(to: @user.email, subject: "Confirm your email address")
  end
end
