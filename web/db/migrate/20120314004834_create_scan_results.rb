class CreateScanResults < ActiveRecord::Migration
  def change
    create_table :scan_results do |t|
      t.integer :app_id
      t.string :sha256
      t.string :filetype
      t.string :vtresource
      t.string :vtscan_id
      t.string :vtpermalink
      t.timestamps
    end
  end
end
