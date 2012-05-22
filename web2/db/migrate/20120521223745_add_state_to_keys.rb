class AddStateToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :state, :string
  end
end
