require 'projects'

task :send_daily_email => :environment do
  Projects.fetch_trending
end