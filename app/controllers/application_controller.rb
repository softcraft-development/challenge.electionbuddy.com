# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :record_current_user
  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

  def record_current_user
    User.current = current_user
  end

  def render_not_found
    render plain: 'Not Found', status: :not_found
  end
end
