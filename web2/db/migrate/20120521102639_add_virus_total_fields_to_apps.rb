class AddVirusTotalFieldsToApps < ActiveRecord::Migration
  def change
    add_column :apps, :vtresource, :string
    add_column :apps, :vtscan_id, :string
    add_column :apps, :vtpermalink, :string
    add_column :apps, :vtsha256, :string
  end
end
