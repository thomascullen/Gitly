require 'projects'

task :fetch_trending => :environment do
  Projects.fetch_trending
end