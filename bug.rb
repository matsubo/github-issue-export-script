require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

client = Octokit::Client.new(access_token: ENV['TOKEN'])

client.auto_paginate = true

prs = client.search_issues("repo:#{ENV['REPOSITORY']} is:issue label:bug created:2023-01-01..2023-09-30 ")['items']

prs_unique = prs.map { |pr| [pr.id, pr] }.to_h

export = prs_unique.map do |_key, pr|
  pr_hash = pr.to_h.slice(:title, :url, :body, :state, :created_at, :closed_at)
  pr_hash[:url].gsub('https://api.github.com/repos', 'https://github.com')
  pr_hash
end

puts export.to_json
