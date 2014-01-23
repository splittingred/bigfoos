class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.string :name
      t.string :code
      t.text :description
      t.integer :prior
      t.string :stat
      t.string :operator
      t.integer :value

      t.timestamps
    end
    add_index :achievements, :prior
    add_index :achievements, :stat
  end
end
