class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :game_id, limit: 11, default: 0, null: false
      t.string :color, limit: 100, default: '', null: false
      t.integer :num_players, limit: 4, default: 2, null: false

      t.timestamps
    end
    add_index :teams, :game_id
  end
end
