class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home category search]
  def home
    @users = User.all
    @products = Product.all
    @markers = @users.geocoded.map do |user|
      {
        lat: user.latitude,
        lng: user.longitude,
        infoWindow: render_to_string(partial: "users/info_window", locals: { user: user }),
        image_url: helpers.asset_url('icon.jpg')
      }
    end
  end

  def profile
    @products = Product.where(user_id: current_user)
  end

  def search
    if params[:query].present?
      @products = Product.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @products = Product.all
    end
  end

  def category
    @category = Category.where("name ILIKE ?", "%#{params[:format]}%")
    @products = Product.where(category: @category)
  end
end
