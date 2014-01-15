class AddProviderToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :provider
    end
  end
end
