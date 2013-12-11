class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :office_id

      t.timestamps
    end
    add_index :favorites, [:user_id, :office_id], unique: true
  end
end
