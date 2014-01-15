class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :uid, null: true

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :uid
  end
end
