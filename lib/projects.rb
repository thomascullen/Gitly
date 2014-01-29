require 'open-uri'

class Projects
	def self.fetch_trending
		categories = Category.where(:name => 'Ruby')
		categories.each do |category|
			self.fetch_projects(category)
		end
	end

	def self.fetch_projects(category)
		#puts "Fetching for #{category.name} for #{Date.yesterday}"
		projects = HTTParty.get(URI.encode('https://api.github.com/search/repositories?language:' + category.github_short + '&sort=stars&order=desc&q=created:>' + Date.yesterday.to_s), :headers => {"User-Agent" => "Gitly"})
		projects['items'].each do |item|
			p item
			break
		end
	end
end

# https://api.github.com/search/repositories?language:Objective-C&sort=stars&order=desc&q=created:>2014-01-21

# curl -G https://api.github.com/search/repositories       \
#     --data-urlencode "q=created:>`date -v-7d '+%Y-%m-%d'`" \
#     --data-urlencode "sort=stars"                          \
#     --data-urlencode "order=desc"                          \
#     -H "Accept: application/vnd.github.preview"            \
#     | jq ".items[0,1,2] | {name, description, language, watchers_count, html_url}"


# curl https://api.github.com/search/repositories?q=language:ActionScript&sort=stars&order=desc