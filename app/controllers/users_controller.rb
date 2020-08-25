class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @users = User.where(user.role == true)
  end

  def show
    @user = current_user
  end

end
