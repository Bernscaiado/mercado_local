class CartsController < ApplicationController
  before_action :product, only: %i[new create]
  before_action :cart, only: %i[edit update destroy]

  def index
    @carts = Cart.where(user: current_user)
    if not @carts.first.nil?
      @order = Order.create!(product: @carts.first.product, product_name: @carts.first.product.name, amount: @carts.first.product.price, state: 'pending', user: current_user)
      @total = total.to_i

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [
          {
          name: 'Your Total',
          images: ['https://picsum.photos/200/300'],
          amount: @total * 100,
          currency: 'brl',
          quantity: 1
        }, ] ,
        success_url: order_url(@order),
        cancel_url: order_url(@order)
      )

      @order.update(checkout_session_id: session.id)
    end
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)
    @cart.product = @product
    @cart.user = current_user
    if @cart.quantity <= @product.quantity && @cart.save
      @product.quantity -= @cart.quantity
      @product.save!
      redirect_to carts_path, notice: 'O produto foi adicionado ao carrinho com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    @product = @cart.product
    basket = @cart.quantity
    quant = params["cart"]["quantity"].to_i
    if quant <= (@product.quantity + basket) && @cart.update(cart_params)
      if quant < basket
        @product.quantity += basket - quant
      else
        @product.quantity -= quant - basket
      end
      @product.save!
      redirect_to carts_path, notice: 'A quantidade foi alterada com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @product = @cart.product
    @product.quantity += @cart.quantity
    @product.save!
    @cart.destroy
    redirect_to carts_url, notice: 'O produto foi removido do carrinho com sucesso'
  end

  private

  def product
    @product = Product.find(params[:product_id])
  end

  def cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.require(:cart).permit(:quantity, :user_id, :product_id)
  end

  def total
    @carts = Cart.where(user: current_user)
    total = 0
    @carts.each do |cart|
      total += cart.quantity * cart.product.price
    end
    return total
  end
end
