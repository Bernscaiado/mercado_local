class OrdersController < ApplicationController

  def create
    @carts = Cart.where(user: current_user)
    @order = Order.create!(product: @carts.first.product, product_name: @carts.first.product.name, amount: @carts.first.product.price, state: 'pendente', user: current_user)
    @total = total

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
        name: 'Your Total',
        images: ['logo.png'],
        amount: @total.to_i,
        currency: 'brl',
        quantity: 1
      }, ] ,
      success_url: order_url(@order),
      cancel_url: order_url(@order)
    )

    @order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(@order)
  end

  def show
    @order = current_user.orders.find(params[:id])
    @carts = Cart.where(user: current_user)
    @total = total
    @carts.delete_all
  end

  private

  def total
    @carts = Cart.where(user: current_user)

    total = 0
    @carts.each do |cart|
      total += cart.quantity * cart.product.price
    end
    return total
  end

end
