class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_filter :set_last_seen_at, if: proc { |p| signed_in? }

private
  def set_last_seen_at
    current_user.update_attribute(:lastSeen, Time.now)
  end

end
