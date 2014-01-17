class AddWlRatioToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.decimal :wl_ratio, :null => false, :default => 0.00, :precision => 5, :scale => 2
    end

    add_index :users, :wl_ratio
  end
end
