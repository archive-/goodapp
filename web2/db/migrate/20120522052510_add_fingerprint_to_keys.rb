class AddFingerprintToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :fingerprint, :string

  end
end
