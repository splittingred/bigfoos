class AddPositionToPlayer < ActiveRecord::Migration
  def change
    change_table :players do |t|
      t.string :position, :null => false, :default => ''
    end

    add_index :players, :position
  end
end
