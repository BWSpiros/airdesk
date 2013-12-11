class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :title
      t.text :description
      t.string :addr1
      t.string :addr2
      t.string :city
      t.string :zip
      t.integer :size
      t.integer :owner_id
      t.boolean :available
      t.integer :occupancy
      t.integer :price
      t.string :arrangement

      t.timestamps
    end
  end
end
