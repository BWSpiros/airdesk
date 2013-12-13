class AddOfficeIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :office_id, :integer
  end
end
