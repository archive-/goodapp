class UserMailer < ActionMailer::Base
  # default :to => "example@goodapp.com"
  default :to => "tj.koblentz@gmail.com"

  def send_contact_mail(from_email, from_name, message)
    body = message
    mail(:subject => "Contact Form filled out by #{from_name}",
         :reply_to => from_email,
         :date => Time.now).deliver
  end

end
