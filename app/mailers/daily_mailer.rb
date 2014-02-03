class DailyMailer < ActionMailer::Base

  default from: "Gitly <daily@gitly.co>"

  def top5(user)
  	@user = user
  	@category = Category.find_by_name("Objective-C")
  	mail(to: @user.email, subject: "Explore trending repo's for today, " + Date.today.strftime("%b %-d"))
  end
end
