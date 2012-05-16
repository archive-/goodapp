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

  def trust_level(user)
    case user.overall_trust
    when 0..20
      'newbie'
    when 80..100
      'worthy'
    else
      'none'
    end
  end
end
