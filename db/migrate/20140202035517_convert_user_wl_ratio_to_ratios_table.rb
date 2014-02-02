class ConvertUserWlRatioToRatiosTable < ActiveRecord::Migration
  def up
    User.all.each do |u|
      r = Ratio.new
      r.user = u
      r.name = 'win-loss'
      r.value = u.wl_ratio
      r.save
    end

    remove_column :users, :wl_ratio
  end

  def down
    change_table :users do |t|
      t.decimal :wl_ratio, :null => false, :default => 0.00, :precision => 5, :scale => 2
    end

    Ratio.where(name: 'win-loss').each do |r|
      u = r.user
      u.wl_ratio = r.value
      u.save
    end
  end
end
