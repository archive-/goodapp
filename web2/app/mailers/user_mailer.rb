class UserMailer < ActionMailer::Base
  # default :to => "example@goodapp.com"
  default :to => "yulia.dubinina@gmail.com"

  def send_contact_mail(from_email, from_name, message)
    body = message
    mail(:subject => "Contact Form filled out by #{from_name}",
         :from => from_email, :body => message).deliver
  end

end
