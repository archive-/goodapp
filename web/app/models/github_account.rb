class GithubAccount < ActiveRecord::Base
  belongs_to :user

  # TODO make this asynchronous?
  def self.sync(user_id, gid, username=nil, avatar_url=nil)
    github_account = GithubAccount.find_or_create_by_user_id(user_id)
    if username.nil? || avatar_url.nil?
      user_json = RestClient.get("https://api.github.com/users/#{params[:username]}")
      github_user = ActiveSupport::JSON.decode(user_json)
      username = github_user["login"]
      avatar_url = github_user["avatar_url"]
    end
    repos_url = "https://api.github.com/users/#{username}/repos"
    repos_json = RestClient.get(repos_url)
    github_repos = ActiveSupport::JSON.decode(repos_json)
    github_account.gid = gid if gid
    github_account.username = username
    github_account.avatar_url = avatar_url
    github_account.repos = github_repos.length
    github_account.watchers = github_repos.inject(0) {|sum, gr| sum += gr["watchers"]}
    # 14379 is how many people are watching rails
    # can't just sum watchers because you get 1 for each repo (but avg is not
    # good either)
    github_account.rating = (github_account.watchers - github_account.repos) / 10000.0
    github_account.save
  end
end
