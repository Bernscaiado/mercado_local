class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @user = current_user
    @products = Product.all
  end

  def profile
    @products = Product.where(user_id: current_user)
  end

  def producer
    @users = User.all
  end

  def search
    if params[:query].present?
      @products = Product.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @products = Product.all
    end
  end

  def category
    @products = Product.where("category ILIKE ?", "%#{params[:format]}%")
  end
end
