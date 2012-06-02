module GithubAccountSyncJob
  @queue = :main

  def self.perform(opts={})
    github_accounts = GithubAccount.all
    github_accounts.each do |github_account|
      GithubAccount.sync(github_account.user_id)
    end
  end
end
