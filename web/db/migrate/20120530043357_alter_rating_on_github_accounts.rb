class AlterRatingOnGithubAccounts < ActiveRecord::Migration
  def change
    remove_column :github_accounts, :rating
    add_column :github_accounts, :rating, :decimal # :precision, :scale
  end
end
