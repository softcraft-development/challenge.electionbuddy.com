# frozen_string_literal: true
require 'user'

class Election < ApplicationRecord
  include ElectionAuditable
  has_many :questions
  belongs_to :user

  serialize :settings, Hash

  def election
    self
  end

  def visibility
    settings[:visibility]
  end

  def visibility=(value)
    settings[:visibility] = value
  end
end
