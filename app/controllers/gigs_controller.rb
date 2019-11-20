class GigsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gig, only: [:show, :destroy]

  def index
    @gigs = Gig.includes(:user).order('created_at DESC').page(params[:page]).per(18)
  end

  def new
    @gig = Gig.new
    # @gig.parts.build
  end

  def create
    @gig = Gig.new(gig_params)
    url = params[:gig][:youtube]
    url = url.last(11)
    @gig.youtube = url
    if @gig.save
      redirect_to root_path
      flash[:notice] = "gigが投稿されました"
    else
      render :new
      flash[:alert] = "gigの投稿に失敗しました"
    end
  end

  def show
    @group = Group.new(group_params)
  end

  def destroy
    if @gig.user == current_user
      flash[:notice] = "gigが削除されました" if @gig.destroy
    else
      flash[:alert] = "gigの削除に失敗しました"
    end
    redirect_to root_path
  end

  private
    def gig_params
      params.require(:gig).permit(:name, :datetime, :location, :genre, :youtube, parts: []).merge(user_id: current_user.id)
    end

    def set_gig
      @gig = Gig.find(params[:id])
    end

    def group_params
      params.permit(:name, user_ids: [] )
    end
end
