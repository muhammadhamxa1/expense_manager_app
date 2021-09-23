class User::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: :create
  #before_action :resource_from_invitation_token, only: [:edit]
  def create
    super
    @user = User.invite!(invite_params, current_user)
    puts(@user.raw_invitation_token)
    # render json: { success: ['User created.'] }, status: :created
  end
  def edit
    super
  end
  def update
    super
    accept_invitation_params[:invitation_token] = @user.raw_invitation_token
    @u = User.accept_invitation!(accept_invitation_params)
    puts @u.errors.full_messages
    if @user.errors.empty?
      puts("Success")
    else
      puts "Unsuccessful"
    end
  end
  protected
    def accept_invitation_params
        params.require(:user).permit(:password,:password_confirmation,:invitation_token,:name)
    end
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [:email,:name])
    end
end





