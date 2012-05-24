class AddStatusToApps < ActiveRecord::Migration
  def change
    add_column :apps, :status, :integer

  end
end
