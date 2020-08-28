class ProductsController < ApplicationController
  before_action :producer?, only: %i[new create edit update destroy]
  before_action :user_check, only: %i[edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @category = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to product_path(@product), notice: 'O produto foi criado com sucesso.'
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @category = Category.all
    if @product.update(product_params)
      redirect_to @product, notice: 'O produto foi editado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to myprofile_url, notice: 'O produto foi removido com sucesso.'
  end

  private

  def producer?
    @user = current_user
    redirect_to products_path unless @user.role == true
  end

  def product_params
    params.require(:product).permit(:name, :category_id, :quantity,
                                    :price, :photo)
  end

  def user_check
    @product = Product.find(params[:id])
    redirect_to products_path unless @product.user == current_user
  end
end
