class AddLastaccesshomeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :lastaccesshome, :datetime, default:DateTime.now
  end
end
