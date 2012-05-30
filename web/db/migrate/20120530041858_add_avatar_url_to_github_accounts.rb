class AddAvatarUrlToGithubAccounts < ActiveRecord::Migration
  def change
    add_column :github_accounts, :avatar_url, :string

  end
end
