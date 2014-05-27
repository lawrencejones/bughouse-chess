class AddLastSeenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lastSeen, :datetime, default: Time.now()
  end
end
