class AddUsernameToGithubAccounts < ActiveRecord::Migration
  def change
    add_column :github_accounts, :username, :string

  end
end
