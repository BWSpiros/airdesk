class AddStateToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :state, :string

    add_column :offices, :website, :string
    add_column :users, :website, :string
  end
end
