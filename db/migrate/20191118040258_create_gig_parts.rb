class CreateGigParts < ActiveRecord::Migration[5.2]
  def change
    create_table :gig_parts do |t|
      t.references :part, index: true, foreign_key: true
      t.references :gig, index: true, foreign_key: true

      t.timestamps
    end
  end
end
