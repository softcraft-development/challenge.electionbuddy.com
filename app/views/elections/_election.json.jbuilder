# frozen_string_literal: true

json.extract! election, :id, :name, :start_at, :end_at, :settings, :created_at, :updated_at
json.url election_url(election, format: :json)
