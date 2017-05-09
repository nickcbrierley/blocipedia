class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  include Pundit
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
  
  def upgrade_to_premium
    current_user.update_attributes(:role => "premium")
  end
  
  def downgrade_to_standard
    current_user.update_attributes(:role => "standard")
    current_user.wikis.each do |pub|
      pub.update_attributes(private: false)
    end
  end
  
end
