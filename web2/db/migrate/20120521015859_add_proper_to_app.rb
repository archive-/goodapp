class AddProperToApp < ActiveRecord::Migration
  def change
    add_column :apps, :proper, :boolean, null: false, default: true
  end
end
