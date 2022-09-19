# NOTE: please pass github token like below
# ruby user_score.rb --token=<TOKEN>
# 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

require 'optparse'
require 'json'
require 'net/http'
require 'uri'

options = {}
OptionParser.new do |opt|
  opt.on('-f', '--token TOKEN') { |o| options[:token] = o }
end.parse!

$token = options[:token]

class UserScore
	
	def initialize
		puts $token
	end

	def create_user_score
		uri = URI.parse("https://api.github.com/events")
		request = Net::HTTP::Get.new(uri)
		request["Accept"] = "application/vnd.github+json"
		request["Authorization"] = "token #{$token}"

		req_options = {
		  use_ssl: uri.scheme == "https",
		}

		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
		  http.request(request)
		end

		if response.code == "200"
			puts "Success"
			events = []
			res = JSON.parse(response.body)
			if res.is_a?(Array) 
				unless res.empty?
					res.each do |r|
						events << r["type"] 
					end
					group_by_events = events.group_by(&:itself).transform_values{|v| v.size}

					event_score = {}
					event_score["IssuesEvent"] = group_by_events.find{|k, v| k == "IssuesEvent"}.last * 7 if events.uniq.include?("IssuesEvent")
					event_score["IssueCommentEvent"] = group_by_events.find{|k, v| k == "IssueCommentEvent"}.last * 6 if events.uniq.include?("IssueCommentEvent")
					event_score["PushEvent"] = group_by_events.find{|k, v| k == "PushEvent"}.last * 5 if events.uniq.include?("PushEvent")
					event_score["PullRequestReviewCommentEvent"] = group_by_events.find{|k, v| k == "PullRequestReviewCommentEvent"}.last * 4 if events.uniq.include?("PullRequestReviewCommentEvent")
					event_score["WatchEvent"] = group_by_events.find{|k, v| k == "WatchEvent"}.last * 3 if events.uniq.include?("WatchEvent")
					event_score["CreateEvent"] = group_by_events.find{|k, v| k == "CreateEvent"}.last * 2 if events.uniq.include?("CreateEvent")
					event_score["PullRequestEvent"] = group_by_events.find{|k, v| k == "PullRequestEvent"}.last * 2 if events.uniq.include?("PullRequestEvent")
					event_score["DeleteEvent"] = group_by_events.find{|k, v| k == "DeleteEvent"}.last * -1 if events.uniq.include?("DeleteEvent")

					total_score = {total_score: event_score.values.inject(:+)}
					puts event_score
					puts total_score
				end
			end
		end
	end
end

UserScore.new.create_user_score