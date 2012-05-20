class AddFieldsToApps < ActiveRecord::Migration
  def change
    add_column :apps, :aid, :integer # can be null but will default to id
    add_column :apps, :version, :string
  end
end
