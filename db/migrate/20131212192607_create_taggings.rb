class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :office_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :taggings, [:tag_id, :office_id], unique: true
  end
end
