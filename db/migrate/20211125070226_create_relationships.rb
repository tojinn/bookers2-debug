class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, foreign_key: { to_table: :users }
      t.integer :followerd_id, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
