class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    # let devise handle confirmation
    super
    # if the user is confirmed -- let's create their email as a key
    if current_user
      email_key = Key.new({user_id: current_user.id, title: current_user.email,
        kee: current_user.email, status: 100, proper: true,
        style: :email, confirmed_at: Time.now}, without_protection: true)
      email_key.update_rating
    end
  end
end
