class ChangeWonToNullStatus < ActiveRecord::Migration
  def change
    change_column :teams, :won, :boolean, null: true
    change_column :players, :won, :boolean, null: true
  end
end
