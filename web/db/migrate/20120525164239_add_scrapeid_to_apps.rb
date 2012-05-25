class AddScrapeidToApps < ActiveRecord::Migration
  def change
    add_column :apps, :scrapeid, :string

  end
end
