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

  def index
    @users = User.where(role: true)
  end

  def show
    @user = User.find(params[:id])
    @products = Product.where(user_id: @user)
  end

  private

  def user_params
    params.require(:user).permit(:address, :brand)
  end
end
