# frozen_string_literal: true

json.extract! voter, :id, :name, :email, :election_id, :created_at, :updated_at
json.url voter_url(voter, format: :json)
