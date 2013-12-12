class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.integer :office_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
