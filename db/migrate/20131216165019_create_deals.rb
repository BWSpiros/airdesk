class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :owner_id
      t.integer :renter_id
      t.integer :office_id
      t.boolean :owner_approval
      t.boolean :renter_approval
      t.date :start_date
      t.date :end_date
      t.integer :price

      t.timestamps
    end
  end
end
