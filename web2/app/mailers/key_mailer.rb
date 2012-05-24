class KeyMailer < ActionMailer::Base
  default from: "goodapp.capstone@gmail.com"

  def email(to_email, key_id)
    @key = Key.find(key_id)
    @key.confirmation_email = to_email
    @key.confirmation_sent_at = Time.now
    @key.confirmation_token = rand(36 ** 32).to_s(36)
    @key.save
    mail(to: to_email,
         subject: "[GoodApp] Confirm your key \"#{@key.title}\"",
         template_path: "keys/mailer",
         template_name: "confirmation")
  end
end
