class AddUniquenessToMemberships < ActiveRecord::Migration
  def up
    remove_index :memberships, :user_id
    remove_index :memberships, :meetup_id
    add_index :memberships, [:user_id, :meetup_id], unique: true
  end
  def down
    add_index :memberships, :user_id
    add_index :memberships, :meetup_id
    remove_index :memberships, [:user_id, :meetup_id]
  end
end
