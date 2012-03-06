module ApplicationHelper
  def bootstrap_flash(type)
    case type
    when :alert
      'warning'
    when :notice
      'info'
    else
      type.to_s
    end
  end

  def control_status(m, field)
    'error' if m.errors[field].present?
    # 'success' if !m.errors[field].present? # TODO fix this
  end
end
