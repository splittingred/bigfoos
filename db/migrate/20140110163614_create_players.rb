class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :user_id, default: 0, null: false
      t.integer :game_id, default: 0, null: false
      t.integer :team_id, default: 0, null: false
      t.integer :points, default: 0, null: false

      t.timestamps
    end
    add_index :players, :user_id
    add_index :players, :team_id
  end
end
