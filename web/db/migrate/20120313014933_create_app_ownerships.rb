class CreateAppOwnerships < ActiveRecord::Migration
  def change
    create_table :app_ownerships do |t|
      t.integer :user_id, :null => false
      t.integer :app_id, :null => false
      t.timestamps
    end
  end
end
