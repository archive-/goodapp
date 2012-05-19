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

end
