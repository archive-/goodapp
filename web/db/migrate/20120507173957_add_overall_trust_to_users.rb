class AddOverallTrustToUsers < ActiveRecord::Migration
  def change
    add_column :users, :overall_trust, :decimal, null: false, default: 0.0
  end
end
