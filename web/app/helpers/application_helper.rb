module ApplicationHelper

  def title(content)
    content_for :title do
      content
    end
    content_tag(:h1, content)
  end

  def bootstrap_flash(type)
    case type
    when :alert
      'danger'
    when :notice
      'info'
    else
      type.to_s
    end
  end

end
