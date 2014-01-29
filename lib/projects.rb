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
end

# https://api.github.com/search/repositories?language:Ruby&sort=stars&order=desc&q=created:>2014-01-28

# curl -G https://api.github.com/search/repositories       \
#     --data-urlencode "q=language:Ruby created:>`date -v-1d '+%Y-%m-%d'`" \
#     --data-urlencode "sort=stars"                          \
#     --data-urlencode "order=desc"                          \
#     -H "Accept: application/vnd.github.preview"            \
#     | jq ".items[0,1,2] | {name, description, language, watchers_count, html_url}"


# curl https://api.github.com/search/repositories?q=language:ActionScript&sort=stars&order=desc