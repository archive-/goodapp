module ApplicationHelper

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
