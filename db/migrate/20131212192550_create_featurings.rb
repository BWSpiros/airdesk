class CreateFeaturings < ActiveRecord::Migration
  def change
    create_table :featurings do |t|
      t.integer :office_id
      t.integer :feature_id

      t.timestamps
    end
    add_index :featurings, [:feature_id, :office_id], unique: true
  end
end
