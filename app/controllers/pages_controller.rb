class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @user = current_user
  end

  def profile
  end

  def producer
    @users = User.all
  end
end
