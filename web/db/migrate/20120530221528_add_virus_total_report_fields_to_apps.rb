class AddVirusTotalReportFieldsToApps < ActiveRecord::Migration
  def change
    add_column :apps, :vtpos, :integer
    add_column :apps, :vttotal, :integer
    add_column :apps, :rating, :decimal
  end
end
