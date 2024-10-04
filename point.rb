require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

client = Octokit::Client.new(access_token: ENV['TOKEN'])

client.auto_paginate = true

search = "repo:#{ENV['REPOSITORY']} is:issue label:\"point manual operation\" created:2024-01-01..2024-09-30 "

issues = client.search_issues(search)['items']

issues_unique = issues.map { |issue| [issue.id, issue] }.to_h

export = issues_unique.map do |_key, issue|
  issue_hash = issue.to_h.slice(:title, :url, :body, :state, :created_at, :closed_at)
  issue_hash[:url].gsub!('https://api.github.com/repos', 'https://github.com')
  issue_hash
end

puts export.to_json
