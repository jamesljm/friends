class AddIndexToFriends < ActiveRecord::Migration[5.2]
  def change
  end

  add_index :friends, :user1_id
  add_index :friends, :user2_id
  add_index :friends, [:user1_id, :user2_id], unique: true
end
