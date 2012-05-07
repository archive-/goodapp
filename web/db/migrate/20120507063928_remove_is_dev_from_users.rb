class RemoveIsDevFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :is_dev
  end
end
