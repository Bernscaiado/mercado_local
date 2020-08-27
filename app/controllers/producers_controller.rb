class ProducersController < ApplicationController
  
  def new
    @producer = User.new
  end

  def create
    @producer = current_user
    if @producer.update(user_params)
      redirect_to root_path
    else 
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:address, :brand)
  end
end
