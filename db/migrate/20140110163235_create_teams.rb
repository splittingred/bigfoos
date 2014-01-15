class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :game_id, default: 0, null: false
      t.string :color, default: '', null: false
      t.integer :num_players, default: 2, null: false

      t.timestamps
    end
    add_index :teams, :game_id
  end
end
