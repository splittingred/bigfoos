class DropGameIdFromPlayers < ActiveRecord::Migration
  def change
    remove_column :players, :game_id
  end
end
