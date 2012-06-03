class AddEndorsementRatingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :endorsement_rating, :decimal, null: false, default: 0.0
  end
end
