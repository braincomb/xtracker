class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name
      t.decimal :fbid
      t.references :user

      t.timestamps
    end
    add_index :friends, :user_id
  end
end
