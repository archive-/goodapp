module DeviseHelper

  def devise_error_messages!(res=nil)
    resource ||= res
    resource.errors.messages
  end

end
