class CreateUserStats < ActiveRecord::Migration
  def change
    create_table :user_stats do |t|
      t.integer :user_id, :null => false, :default => 0
      t.string :name, :null => false, :default => ''
      t.integer :value, :null => false, :default => 0

      t.timestamps
    end
    add_index :user_stats, :user_id
    add_index :user_stats, :name
  end
end
