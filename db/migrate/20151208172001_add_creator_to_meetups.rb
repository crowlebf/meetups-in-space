class AddCreatorToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :creator, :integer, null: false
  end
end
