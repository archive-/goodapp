module UsersHelper
  def its_you
    @user == current_user
  end

  def user_show(user)
    raw("<a href=\"#{user_url(user)}\" rel=\"tooltip\" class=\"#{'dev ' if user.is_dev}user tooltipped\" title=\"#{user.name}\">#{image_tag user.avatar.url(:thumb)}</a>")
  end
end
