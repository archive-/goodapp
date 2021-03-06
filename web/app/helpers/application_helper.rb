module ApplicationHelper

  def title(title)
    content_for :title do
      "| #{title}" unless title.blank?
    end
    title
  end

  def active?(str)
    case str
    when Symbol
      session[:tab] == str
    when String
      request.path == str
    else
      false
    end ? "active" : ""
  end

  def bootstrap_flash(type)
    case type
    when :alert
      'danger'
    when :notice
      'success'
    else
      type.to_s
    end
  end

  def show_platform(platform)
    return if platform.nil? || platform.blank?
    case platform.to_sym
    when :android
      image_tag "android-robot-logo.jpg", width: "24", style: "vertical-align: 0"
    else
      "??"
    end
  end

  def haml_tag_if(condition, *args, &block)
    condition ? haml_tag(*args, &block) : yield
  end

  def github_url
    "https://github.com/tjeezy/goodapp"
  end

end
