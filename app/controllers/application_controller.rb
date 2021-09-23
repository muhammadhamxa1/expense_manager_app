class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

   
    before_action :authenticate_user!
    include Pundit
    # after_action :verify_authorized,unless: :devise_controller?
    before_action :configure_permitted_parameters, if: :devise_controller?
    private

    def record_not_found
      redirect_to '/404'
    end

    def user_not_authorized
      respond_to do |format|
        format.html { redirect_to (request.referer || '/') ,alert: 'you are not authorized!' }
      end
    end
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name])
        # controller_you_want = ControllerYouWant.new
        # @wallet = Wallet.new()
        # redirect_to url_for(:controller => :controller_name, :action => :action_name)
    end
  
end
