module UserHelper
  def rating(user)
    raw("<span id=\"trust-tag\" class=\"label\">#{"%+.2f" % user.rating}</span>")
  end
end
