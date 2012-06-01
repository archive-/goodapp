class AlterRatingForApps < ActiveRecord::Migration
  def change
    remove_column :apps, :rating
    add_column :apps, :vtrating, :decimal
  end
end
