class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
      flash[:notice] = "プロフィールを編集しました"
    else
      redirect_to edit_user_path(current_user)
      flash[:alert] = "プロフィールの編集に失敗しました"
    end
  end

  def show
    @user = User.find(params[:id])
    @userGigs = @user.gigs.order('datetime DESC')
    entry_gigs = Array.new
    @user.entries.each do |entry|
      entry_gigs.push(entry.gig)
    end
    @entry_gigs = entry_gigs.sort_by{|e| e[:datetime]}.reverse!
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