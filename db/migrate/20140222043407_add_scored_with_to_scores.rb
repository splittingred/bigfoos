class AddScoredWithToScores < ActiveRecord::Migration
  def change
    add_column :scores, :scored_with, :integer, :default => 0, null: false
  end
end
