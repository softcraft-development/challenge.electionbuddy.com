# frozen_string_literal: true

json.extract! question, :id, :name, :answer_ids, :created_at, :updated_at
json.url question_url(question, format: :json)
