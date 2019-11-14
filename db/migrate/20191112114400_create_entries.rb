class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.text :content
      t.references :user, foreign_key: true, null: false
      t.references :gig, foreign_key: true, null: false
      t.timestamps
    end
  end
end
