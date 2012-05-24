class AddPersonalInfosToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
    add_column :users, :name, :string, null: false, default: ""
  end
end
