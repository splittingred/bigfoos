class RenameColorToColorId < ActiveRecord::Migration
  def change
    rename_column :teams, :color, :color_id
  end
end
