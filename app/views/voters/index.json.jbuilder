# frozen_string_literal: true

json.array! @voters, partial: 'voters/voter', as: :voter
