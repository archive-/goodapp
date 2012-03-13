class CreateAppUsages < ActiveRecord::Migration
  def change
    create_table :app_usages do |t|
      t.integer :user_id, :null => false
      t.integer :app_id, :null => false
      t.timestamps
    end
  end
end
