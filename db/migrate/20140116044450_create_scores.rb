class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :player_id, default: 0, null: false
      t.integer :game_id, default: 0, null: false

      t.timestamps
    end

    add_index :scores, :player_id
    add_index :scores, :game_id
  end
end
