class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[update edit]

  # GET /groups or /groups.json
  def index
    # byebug  
    @groups = current_user.groups
    @group_members=GroupMember.all
    # @group_members=@group.GroupMember.all
  end

  # GET /groups/1 or /groups/1.json
  def show
    # byebug  
    @group_members=@group.group_members
    # @group_members
  end

  # GET /groups/new
  def new
    @group = Group.new
    


  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.create(group_params)
    @group.user_id=current_user.id
    @group_expense.user_id=current_user.id
    
      if @group.save
        @group_member=GroupMember.new
        @group_member.user_id=current_user.id
        @group_member.group_id=@group.id
        @group_member.save
        # byebug
        redirect_to @group, notice: "Group was successfully created."
      else
        render :new, status: :unprocessable_entity 
      end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    if(group_params.has_key?(:email))
      # byebug
      if (User.find_by_email(group_params[:email]) != nil)
        @user=User.find_by_email(group_params[:email])
        @group_member=GroupMember.new
        @group_member.user_id=@user.id
        @group_member.group_id=@group.id
        @group_member.save
        redirect_to @group, notice: "User sucessfullly Added." 
      else
        # byebug
        @user = User.invite!(group_params, current_user)
        puts(@user.raw_invitation_token)
        @user=User.find_by_email(group_params[:email])
        @group_member=GroupMember.new
        @group_member.user_id=@user.id
        @group_member.group_id=@group.id
        @group_member.save
        redirect_to @group, notice: "Invitation has been sucesfully send" 
      end
    else
      if @group.update(group_params)
        redirect_to @group, notice: "Group was successfully updated." 
      else
        render :edit, status: :unprocessable_entity 
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy
      redirect_to groups_url, notice: "Group was successfully destroyed." 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      # byebug
      @group = Group.find(params[:id])
    end

    def set_user
      @group = Group.find(params[:id])
      @user = User.find_by_email(params[:email])
    end

    # Only allow a list of trusted parameters through.
    def group_params
      if(params[:group] != nil)
        params.require(:group).permit(:group_name)
      elsif params[:user] != nil
        params.require(:user).permit(:email)  
      end
    end
end
