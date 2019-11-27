class AddVisitedAtToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :visited_at, :datetime
  end
end
