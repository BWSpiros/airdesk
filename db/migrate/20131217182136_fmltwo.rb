class Fmltwo < ActiveRecord::Migration
  def change
    rename_column :users, :longitute, :longitude
  end
end
