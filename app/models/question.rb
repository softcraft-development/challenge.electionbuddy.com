# frozen_string_literal: true

class Question < ApplicationRecord
  include ElectionAuditable
  belongs_to :election
  has_many :answers
end
