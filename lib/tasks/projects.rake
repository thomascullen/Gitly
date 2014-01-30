require 'projects'

task :fetch_trending => :environment do
  Projects.fetch_trending
end

task :send_daily_mail => :environment do
  Projects.send_updates
end