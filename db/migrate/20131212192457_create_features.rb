class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :feature_name

      t.timestamps
    end
    add_index :features, :feature_name, unique: true
  end
end
