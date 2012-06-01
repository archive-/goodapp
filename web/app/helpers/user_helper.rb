module UserHelper

  def ratingclass(rating)
    case rating.to_i
    when 0..20
      "trust-none"
    when 20..40
      "trust-low"
    when 40..60
      "trust-midlow"
    when 60..80
      "trust-midhigh"
    when 80...100
      "trust-high"
    else
      "notrust"
    end
  end

  def rating(user)
    raw("<span id=\"trust-tag\" class=\"label #{ratingclass(user.rating)}\">#{"%02.2f" % user.rating}</span>")
  end
end
