class CartsController < ApplicationController

  def index
    @carts = Cart.where(user: current_user)
  end

  def new
    @product = Product.find(params[:product_id])
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)
    @product = Product.find(params[:product_id])
    @cart.product = @product
    @cart.user = current_user
    if @cart.save
      redirect_to carts_path, notice: 'O produto foi adicionado ao carrinho com sucesso.'
    else
      render :new
    end
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def update
    @cart = Cart.find(params[:id])
    if @cart.update(cart_params)
      redirect_to carts_path, notice: 'O produto foi adicionado ao carrinho com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_url, notice: 'O produto foi removido do carrinho com sucesso'
  end

  private

  def cart_params
    params.require(:cart).permit(:quantity, :user_id, :product_id)
  end
end
