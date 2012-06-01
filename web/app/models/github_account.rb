class GithubAccount < ActiveRecord::Base
  attr_accessible #none

  belongs_to :user

  # TODO make this asynchronous?
  def self.sync(user_id, username=nil)
    # TODO this is soooo ugly and huge -- wtf!
    github_account = GithubAccount.find_or_create_by_user_id(user_id)
    username ||= github_account.username
    raise "Cannot Github sync -- don't know #<User id:#{user_id}>'s login" unless username
    user_json = RestClient.get("https://api.github.com/users/#{username}")
    github_user = ActiveSupport::JSON.decode(user_json)
    github_account.gid = github_user["id"]
    github_account.avatar_url = github_user["avatar_url"]
    repos_url = "https://api.github.com/users/#{username}/repos"
    repos_json = RestClient.get(repos_url)
    github_repos = ActiveSupport::JSON.decode(repos_json)
    github_account.username = username
    github_account.repos = github_repos.length
    github_account.watchers = github_repos.inject(0) {|sum, gr| sum += gr["watchers"]}
    # 14379 is how many people are watching rails
    # can't just sum watchers because you get 1 for each repo (but avg is not
    # good either)
    rating = (github_account.watchers - github_account.repos) / 10000.0
    github_account.rating = rating > 1.0 ? 1.0 : rating
    github_account.save
  end
end
