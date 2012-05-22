class KeyConfirmer < ActionMailer::Base
  default from: "confirmations@goodapp.com"

  def email(addr, key_id)
    @key = Key.find(key_id)
    @key.confirmation_email = addr
    @key.confirmation_sent_at = Time.now
    @key.confirmation_token = rand(36 ** 32).to_s(36)
    @key.save
    mail(to: addr,
         subject: "[GoodApp] Confirm your key \"#{@key.title}\"",
         template_path: "keys/mailer",
         template_name: "confirmation")
  end
end
