class CreateGigs < ActiveRecord::Migration[5.2]
  def change
    create_table :gigs do |t|
      t.string :name
      t.datetime :datetime
      t.string :location
      t.string :genre
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
