require 'rubygems'
require 'bundler/setup'
require 'active_support/all'


Bundler.require(:default)
Dotenv.load

client = Octokit::Client.new(access_token: ENV['TOKEN'])

client.auto_paginate = true

prs = []

# max 1000 records due to github API restriction.
1.upto(9).each do |month|
  date = Date.new(2024, month, 1)
  search = "repo:#{ENV['REPOSITORY']} is:pr base:develop closed:#{date.strftime("%Y-%m-%0d")}..#{date.at_end_of_month.strftime("%Y-%m-%0d")}  is:merged"
  prs += client.search_issues(search)['items'].map do |pr|
    pr_hash = pr.to_h.slice(:title, :url, :state, :created_at, :closed_at)
    pr_hash[:url].gsub!('https://api.github.com/repos/', 'https://github.com/')
    pr_hash
  end

end

puts prs.to_json
