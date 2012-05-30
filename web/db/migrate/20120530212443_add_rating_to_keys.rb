class AddRatingToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :rating, :decimal # :precision, :scale

  end
end
