class AddWonToTeam < ActiveRecord::Migration
  def change
    change_table :teams do |t|
      t.boolean :won, :default => false, :null => false
    end
    change_table :players do |t|
      t.boolean :won, :default => false, :null => false
    end

    add_index :teams, :won
    add_index :players, :won
  end
end
