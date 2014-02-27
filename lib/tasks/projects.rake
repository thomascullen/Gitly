require 'projects'

task :fetch_trending => :environment do
	if Time.now.friday?
  	Projects.fetch_trending
  end
end

task :send_weekly_mail => :environment do
	if Time.now.friday?
  	Projects.send_updates
  end
end

task :send_test_mail => :environment do
  Projects.send_test_update
end