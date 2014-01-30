require 'open-uri'

class Projects
	def self.fetch_trending
		categories = Category.all
		categories.each do |category|
			if category.users.count > 0
				self.fetch_projects(category)
			end
		end
	end

	def self.fetch_projects(category)
		uri = URI.encode('https://api.github.com/search/repositories?q=language:' + category.github_short + ' created:>' +  2.days.ago.strftime("%Y-%m-%d") + '&sort=stars&order=desc&client_id=' + ENV['GITHUB_CLIENT'] + '&client_secret=' + ENV['GITHUB_SECRET'])
		puts "URL: #{uri}"

		projects = HTTParty.get(uri, :headers => {"User-Agent" => "Gitly"})
		if projects['items'] && projects['items'].count > 0
			projects['items'].each do |item|
				project = Project.where(:github_id => item['id']).first_or_create

				project.name = item['name']
				project.url = item['html_url']
				project.description = item['description']
				project.stargazers = item['stargazers_count']
				project.watchers = item['watchers_count']
				project.github_id = item['id']
				project.created_by = item['owner']['login']
				project.avatar_url = item['owner']['avatar_url']
				project.save

				category.projects << project unless category.projects.include?(project)

				p "Saved project #{project.name} to #{category.name} under language #{item['language']} for GitHub id #{project.github_id}"
				p project.url
			end
		end
	end

	def self.send_updates
		puts "Sending the mails..."

		users = User.where(:active => true, :verified => true)
		users.each do |user|

			count = 0
			user.categories.each {|category| count = count + category.projects.count}
			if count > 0
				puts "Sending mail to #{user.email}"
				DailyMailer.top5(user).deliver
			else
				puts "No projects to send"
			end
		end
	end
end