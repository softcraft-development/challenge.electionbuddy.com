# frozen_string_literal: true

class Voter < ApplicationRecord
  include ElectionAuditable
  belongs_to :election
end
