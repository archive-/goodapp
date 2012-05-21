module ApplicationHelper

  def title(title)
    content_for :title do
      "| #{title}" unless title.blank?
    end
    title
  end

  def active?(url)
    url == request.path ? 'active' : ''
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
    return unless !platform.blank?
    case platform.to_sym
    when :android
      image_tag "android-robot-logo.jpg", width: "24"
    else
      "unknown"
    end
  end

  def haml_tag_if(condition, *args, &block)
    condition ? haml_tag(*args, &block) : yield
  end

end
