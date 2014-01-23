class AddEndedAtToGame < ActiveRecord::Migration
  def change
    change_table :games do |t|
      t.datetime :ended_at
    end
  end
end
