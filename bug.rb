require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

client = Octokit::Client.new(access_token: ENV['TOKEN'])

client.auto_paginate = true

prs = client.search_issues("repo:#{ENV['REPOSITORY']} is:issue label:bug created:2022-01-01..2022-09-30")['items']

prs_unique = prs.map { |pr| [pr.id, pr] }.to_h

export = prs_unique.map do |_key, pr|
  pr.to_h.slice(:title, :url, :body, :state, :created_at, :closed_at)
end

puts export.to_json
