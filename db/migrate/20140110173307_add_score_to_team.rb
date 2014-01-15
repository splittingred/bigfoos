class AddScoreToTeam < ActiveRecord::Migration
  def change
    change_table :teams do |t|
      t.integer :score, :default => 0, :null => false
    end
  end
end
