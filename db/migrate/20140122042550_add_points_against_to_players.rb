class AddPointsAgainstToPlayers < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.integer :points_against, :null => false, :default => 0
    end
  end
end
