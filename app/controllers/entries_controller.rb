class EntriesController < ApplicationController
  before_action :set_gig

  def index
    @entry = Entry.new
    @entries = @gig.entries.includes(:user)
    @entry_array = Array.new
    @gig.entries.each do |entry|
      @entry_array.push(entry.user_id)
    end
    if @gig.user == current_user && @gig.entries.present?
      if @gig.entries.last.visited_at == nil || @gig.entries.last.visited_at.present?
        if @gig.entries.last.visited_at == nil || @gig.entries.last.created_at > @gig.entries.last.visited_at
          @gig.entries.last.visited_at = DateTime.now
          @gig.entries.last.save
        end
      end
    end
  end

  def create
    @entry = @gig.entries.new(entry_params)  
    if @entry.save
      redirect_to gig_entries_path(@gig), notice: "エントリーが完了ました"
    else
      @entries = @gig.entries.includes(:user)
      flash.now[:alert] = "エントリーできませんでした"
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

