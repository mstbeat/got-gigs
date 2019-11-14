class AddYoutubeToGigs < ActiveRecord::Migration[5.2]
  def change
    add_column :gigs, :youtube, :string
  end
end
