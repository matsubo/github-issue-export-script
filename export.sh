#!/bin/bash

bundle exec ruby pr.rb  | jq -r '["title","url","state", "created_at", "closed_at"],(.[] | [.title, .url, .state, .created_at, .closed_at]) | @csv' | nkf -s > pr.csv
bundle exec ruby issue.rb | jq -r '["title","body", "url","state", "created_at", "closed_at"],(.[] | [.title, .body, .url, .state, .created_at, .closed_at]) | @csv' | nkf -s > issue.csv
bundle exec ruby point.rb | jq -r '["title","body", "url","state", "created_at", "closed_at"],(.[] | [.title, .body, .url, .state, .created_at, .closed_at]) | @csv' | nkf -s > point.csv
bundle exec ruby bug.rb   | jq -r '["title","body", "url","state", "created_at", "closed_at"],(.[] | [.title, .body, .url, .state, .created_at, .closed_at]) | @csv' | nkf -s > bug.csv

