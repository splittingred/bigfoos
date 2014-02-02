class AddRatiosTable < ActiveRecord::Migration
  def change
    create_table :ratios do |t|
      t.integer :user_id
      t.string :name
      t.decimal :value, :null => false, :default => 0.00, :precision => 5, :scale => 2

      t.timestamps
    end
    add_index :ratios, :user_id
    add_index :ratios, :name
  end
end
