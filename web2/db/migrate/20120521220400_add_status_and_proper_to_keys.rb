class AddStatusAndProperToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :status, :integer
    add_column :keys, :proper, :boolean, null: false, default: true
  end
end
