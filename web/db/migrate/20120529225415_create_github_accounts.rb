class CreateGithubAccounts < ActiveRecord::Migration
  def change
    create_table :github_accounts do |t|
      t.integer :user_id, null: false
      t.integer :gid
      t.integer :repos
      t.integer :watchers
      t.integer :rating

      t.timestamps
    end
  end
end
