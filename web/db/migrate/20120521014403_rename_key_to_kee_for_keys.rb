class RenameKeyToKeeForKeys < ActiveRecord::Migration
  def up
    remove_column :keys, :key
    add_column :keys, :kee, :text, null: false, default: ""
  end

  def down
    remove_column :keys, :kee
    add_column :keys, :key, :text, null: false, default: ""
  end
end
