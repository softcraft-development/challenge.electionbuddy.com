# frozen_string_literal: true

class Voter < ApplicationRecord
  belongs_to :election
end
