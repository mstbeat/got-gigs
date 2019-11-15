class MessagesController < ApplicationController
  # before_action :set_group
  before_action :authenticate_user!, :only => [:create]

  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
  end

  def create
    # @message = @group.messages.new(message_params)
    # if @message.save
    #   redirect_to group_messages_path(@group)
    # else
    #   @messages = @group.messages.includes(:user)
    #   render :index
    # end
    if GroupUser.where(:user_id => current_user.id, :group_id => params[:message][:group_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :group_id).merge(:user_id => current_user.id))
      redirect_to "/groups/#{@message.group_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def message_params
      params.require(:message).permit(:content).merge(user_id: current_user.id)
    end

    def set_group
      @group = Group.find(params[:group_id])
    end
end
