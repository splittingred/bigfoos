class AddScoreToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :score, :null => false, :default => 0
    end

    add_index :users, :score
  end
end
