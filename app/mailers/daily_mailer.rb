class DailyMailer < ActionMailer::Base

  default from: "Gitly <no-reply@gitly.co>"

  def top5(user)
  	@user = user
  	@category = Category.find_by_name("Objective-C")
  	mail(to: @user.email, subject: "Your daily dose of trending repos over the last 7 days")
  end
end
