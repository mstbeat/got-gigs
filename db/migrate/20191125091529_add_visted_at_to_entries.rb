class AddVistedAtToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :visited_at, :datetime
  end
end
