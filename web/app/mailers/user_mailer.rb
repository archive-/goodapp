class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  default to: "yulia.dubinina@gmail.com"

  def deliver_message_from_visitor(email, message)
    subject = "Email sent via your website"
    body = message
    recipients = "skiswithtwotips@gmail.com"
    from = email
    sent_on = Time.now
    mail(:to => recipients, :subject => subject)    
  end

end
