require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)
Dotenv.load

client = Octokit::Client.new(access_token: ENV['TOKEN'])

client.auto_paginate = true

prs = client.search_issues("repo:#{ENV['REPOSITORY']} is:pull-request base:develop merged:2022-01-01..2022-09-30")['items'].map do |pr|
  pr.to_h.slice(:title, :url, :state, :created_at, :closed_at)
end

puts prs.to_json
