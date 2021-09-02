class ApplicationController < ActionController::Base
    include Pundit
    # after_action :verify_authorized,unless: :devise_controller?
    before_action :configure_permitted_parameters, if: :devise_controller?


    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name])
        # controller_you_want = ControllerYouWant.new
        # @wallet = Wallet.new()
        # redirect_to url_for(:controller => :controller_name, :action => :action_name)
    end
  
end
