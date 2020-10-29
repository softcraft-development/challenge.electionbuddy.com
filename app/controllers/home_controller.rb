# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    redirect_to elections_path if user_signed_in?
  end
end
