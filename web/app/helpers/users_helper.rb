module UsersHelper
  def its_you
    @user == current_user
  end

  def user_show(user)
    raw("<a href=\"#{user_url(user)}\" rel=\"tooltip\" class=\"#{'dev ' if user.has_role? :dev}user tooltipped\" title=\"#{user.name}\">#{image_tag user.avatar.url(:thumb)}</a>")
  end

  def user_name_show(user)
    link_to (user == current_user) ? 'You' : user.name, user
  end
end
