class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @users = User.where(user.role == true)
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { flat: flat }),
        image_url: helpers.asset_url('icon.jpg')
      }
    end
  end

  def show
    @user = current_user
  end

end
