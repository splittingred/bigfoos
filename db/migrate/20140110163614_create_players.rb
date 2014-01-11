class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :user_id, limit: 11, default: 0, null: false
      t.integer :game_id, limit: 11, default: 0, null: false
      t.integer :team_id, limit: 11, default: 0, null: false
      t.integer :points, limit: 4, default: 0, null: false

      t.timestamps
    end
    add_index :players, :user_id
    add_index :players, :team_id
  end
end
