require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

client = Octokit::Client.new(access_token: ENV['TOKEN'])

client.auto_paginate = true

words = %w[不正 SQL]

prs = []
words.each do |word|
  prs.concat(client.search_issues("repo:#{ENV['REPOSITORY']} is:issue #{word} created:2022-01-01..2022-09-30")['items'])
end

prs_unique = prs.map { |pr| [pr.id, pr] }.to_h

export = prs_unique.map do |_key, pr|
  pr.to_h.slice(:title, :url, :body, :state, :created_at, :closed_at)
end

puts export.to_json
