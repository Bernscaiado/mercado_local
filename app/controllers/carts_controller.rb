class CartsController < ApplicationController

  def index
    @carts = Cart.where(user: current_user)
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

  def total

    @carts = Cart.where(user: current_user)

    total = 0
    @carts.each do |cart|
      total += cart.quantity * cart.product.price
    end
    return total
  end
end
