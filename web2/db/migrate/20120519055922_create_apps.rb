class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.integer :key_id, null: false
      t.string :title

      t.timestamps
    end
  end
end
