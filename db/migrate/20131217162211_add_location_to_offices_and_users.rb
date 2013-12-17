class AddLocationToOfficesAndUsers < ActiveRecord::Migration
  def change
    add_column :offices, :latitude, :float
    add_column :offices, :longitute, :float
    add_column :users, :latitude, :float
    add_column :users, :longitute, :float
  end
end
