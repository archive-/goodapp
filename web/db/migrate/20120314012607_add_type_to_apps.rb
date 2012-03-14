class AddTypeToApps < ActiveRecord::Migration
  def change
    add_column :apps, :type, :string

  end
end
