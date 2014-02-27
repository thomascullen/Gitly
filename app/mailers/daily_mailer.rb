class DailyMailer < ActionMailer::Base

  default from: "Gitly <daily@gitly.co>"

  def top5(user)
  	@user = user
  	mail(to: @user.email, subject: "Explore trending repo's over the last week")
  end
end
