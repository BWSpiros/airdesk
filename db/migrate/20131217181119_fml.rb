class Fml < ActiveRecord::Migration
  def change
    rename_column :offices, :longitute, :longitude
  end
end
