
class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # Add unique composite index to ensure one user can follow another user only once.
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
