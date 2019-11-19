class AddPartsToGigs < ActiveRecord::Migration[5.2]
  def change
    add_column :gigs, :parts, :text, array: true
  end
end
