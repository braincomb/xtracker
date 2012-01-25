class CreateDeletions < ActiveRecord::Migration
  def change
    create_table :deletions do |t|
      t.string :name
      t.integer :fbid, :limit => 8
      t.references :user

      t.timestamps
    end
    add_index :deletions, :user_id
  end
end
