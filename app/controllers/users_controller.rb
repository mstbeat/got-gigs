class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def show
    @user = User.find(params[:id])
    @currentUserEntry = GroupUser.where(user_id: current_user.id)
    @userEntry = GroupUser.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.group_id == u.group_id then
            @isGroup = true
            @groupId = cu.group_id
          end
        end
      end
      if @isGroup
      else
        @group = Group.new
        @group_user = GroupUser.new
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :image)
    end
  
end