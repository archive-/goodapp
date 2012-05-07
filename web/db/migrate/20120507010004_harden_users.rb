class HardenUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name
    add_column :users, :name, :string, null: false, default: ''
    remove_column :users, :is_dev
    add_column :users, :is_dev, :boolean, null: false, default: false
  end
end
