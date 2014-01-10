class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, limit: 255, null: false
      t.string :email, limit: 255, null: false
      t.string :uid, limit: 255, null: true

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :uid
  end
end
