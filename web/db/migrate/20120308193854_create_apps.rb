class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :file_fingerprint

      t.timestamps
    end
  end
end
