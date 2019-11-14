class EntriesController < ApplicationController
  before_action :set_gig

  def index
    @entry = Entry.new
    @entries = @gig.entries.includes(:user)
  end

  def create
    @entry = @gig.entries.new(entry_params)  
    if @entry.save
      redirect_to gig_entries_path(@gig), notice: "エントリーが送信されました"
    else
      @entries = @gig.entries.includes(:user)
      flash.now[:alert] = "エントリーを入力してください"
      redirect_to gig_entries_path(@gig)
    end
  end

  private

    def entry_params
      params.require(:entry).permit(:content).merge(user_id: current_user.id)
    end

    def set_gig
      @gig = Gig.find(params[:gig_id])
    end
end
