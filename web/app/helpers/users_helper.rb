module UsersHelper
  def its_you
    @user == current_user
  end
end
