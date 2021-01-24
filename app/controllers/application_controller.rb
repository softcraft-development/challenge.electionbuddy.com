# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :record_current_user

  def record_current_user
    User.current = current_user
  end
end
