class ChangePartsToAllowNullToGig < ActiveRecord::Migration[5.2]
  def change
    change_column :gigs, :parts, :text, null: true
  end
end
