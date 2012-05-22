class AddStateToApps < ActiveRecord::Migration
  def change
    add_column :apps, :state, :string

  end
end
