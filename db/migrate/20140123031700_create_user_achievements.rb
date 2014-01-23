class CreateUserAchievements < ActiveRecord::Migration
  def change
    create_table :user_achievements do |t|
      t.integer :achievement_id
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
    add_index :user_achievements, :achievement_id
    add_index :user_achievements, :user_id
    add_index :user_achievements, :game_id
  end
end
