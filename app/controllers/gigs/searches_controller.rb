class Gigs::SearchesController < ApplicationController
  def index
    @gigs = Gig.search(params[:keyword]).includes(:user).where('datetime >= ?', Time.now).order('datetime ASC').page(params[:page]).per(18)
  end
end
