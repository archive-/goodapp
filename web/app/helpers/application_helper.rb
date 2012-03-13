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

  def control_status(m, field)
    'error' if m.errors[field].present?
    # 'success' if !m.errors[field].present? # TODO fix this
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
