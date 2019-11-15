class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    
  end

  def create
    # @group = Group.new(group_params)
    # @group.users << current_user
    # if @group.save
    #   redirect_to group_messages_path(@group)
    # else
    #   redirect_to root_path
    # end
    @group = Group.create
    @entry1 = GroupUser.create(:group_id => @group.id, :user_id => current_user.id)
    @entry2 = GroupUser.create(params.require(:group_user).permit(:user_id, :group_id).merge(:group_id => @group.id))
    redirect_to "/groups/#{@group.id}"
  end

  def show
    @group = Group.find(params[:id])
    if GroupUser.where(:user_id => current_user.id, :group_id => @group.id).present?
      @messages = @group.messages
      @message = Message.new
      @group_users = @group.group_users
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def group_params
      params.require(:group).permit(:name, user_ids: [] )
    end
end
