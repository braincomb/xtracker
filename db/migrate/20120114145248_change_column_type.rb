class ChangeColumnType < ActiveRecord::Migration
  def up
    change_column :users, :fbid, :integer, :limit => 8
    change_column :friends, :fbid, :integer, :limit => 8
  end

  def down
  end
end
