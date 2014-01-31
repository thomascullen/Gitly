class UserMailer < ActionMailer::Base
  default from: "Gitly <no-reply@gitly.co>"

  def validate_user(user)
  	@user = user
  	mail(to: @user.email, subject: "Confirm your email address")
  end

  def notify_admin(user, message)
  	@user = user
  	@message = message

  	mail(to: "brian@minicorp.ie", subject: "Admin Notification")
  end
end
