class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :session
      t.string :city
      t.string :phone_number
      t.string :business_name
      t.text :business_description
      t.string :password_digest

      t.timestamps
    end
  end
end
