class RenamePositionToPositionId < ActiveRecord::Migration
  def change
    rename_column :players, :position, :position_id
  end
end
