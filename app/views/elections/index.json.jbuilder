# frozen_string_literal: true

json.array! @elections, partial: 'elections/election', as: :election
