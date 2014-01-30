require 'open-uri'

class Projects
	def self.fetch_trending
		categories = Category.all
		categories.each do |category|
			if category.users.count > 0
				self.fetch_projects(category)
				sleep(20.0)
			end
		end
	end

	def self.fetch_projects(category)
		uri = URI.encode('https://api.github.com/search/repositories?q=language:' + category.github_short + ' created:>' +  1.week.ago.strftime("%Y-%m-%d") + '&sort=stars&order=desc')
		puts "URL: #{uri}"

		projects = HTTParty.get(uri, :headers => {"User-Agent" => "Gitly"})
		if projects['items'] && projects['items'].count > 0
			projects['items'].each do |item|
				project = Project.where(
					:name => item['name'],
					:url => item['html_url'],
					:description => item['description'],
					:stargazers => item['stargazers_count'],
					:watchers => item['watchers_count'],
					:github_id => item['id'],
					:created_by => item['owner']['login'],
					:avatar_url => item['owner']['avatar_url']
				).first_or_create

				category.projects << project unless category.projects.include?(project)

				p "Saved project #{project.name} to #{category.name} under language #{item['language']}"
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