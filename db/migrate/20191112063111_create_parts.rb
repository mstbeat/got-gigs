class CreateParts < ActiveRecord::Migration[5.2]
  def change
    create_table :parts do |t|
      t.string :name, null: false
      t.references :gig, foreign_key: true, null: false
      t.timestamps
    end
  end
end
