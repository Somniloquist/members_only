ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def logged_in?
    !session[:current_user_id].nil?
  end

  def logged_out?
    session[:current_user_id].nil?
  end
end
