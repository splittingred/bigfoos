class AddStatusToGames < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.string :status, :default => 'active', :null => false
    end

    add_index :games, :status
  end
end
