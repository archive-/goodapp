class UserMailer < ActionMailer::Base
  default to: "goodapp.capstone@gmail.com"

  def email(from_email, from_name, body)
    mail(:subject => "Contact Form filled out by #{from_name}",
         :from => from_email,
         :body => body)
  end

end
