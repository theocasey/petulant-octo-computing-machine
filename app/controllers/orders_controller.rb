class OrdersController < ApplicationController
  def index
  	# a list of the past orders a current user has 
  	if current_user.present? 
  		@orders = current_user.orders.all?
  	else
  		flash[:error] = "You must be signed in"	
  		redirect_to root_path
  end

  def show
  	# be a thanks page, this is your order
  	@order = Order.find(params[:id])
  end

  def new
  	# place an order form
  	@order = Order.new

  	# add the basket stuff to the order
  	# overwrite the new order with an updated one with basket stuff
  	@order = build_order(@order)

  	if current_user.present?
  		@order.name = current_user.name
  		@order.email = current_user.name
  	end

  end

  def create 
  	# actually pay for an order
  	# process the payment and redirect to the show page
  	@order = Order.new(order_params)
  	@order = build_order(@order)

  	if current_user.present? 
  		@order.user = current_user
  	end

  	if @order.save 

  		Stripe::Charge.create(
  			amount: @order.total_price, 
  			currency: "gbp", 
  			card: @order.stripe_token, 
  			description: "Order number #{@order.id} - #{@order.email}"
  			)


  		basket.clear
  		flash[:success] = "Thanks for ordering"
  		redirect_to order_path(@order)
  	else 
  		render "new"
  	end 

  end 

  private

  def order_params
  	params.require(:order).permit(:name, :email, :address_1, :address_2, :city, :country, :post_code, :stripe_token)
  end

  def build_order(o)
  	# add all the session basket stuff to the order itself
  	basket.each do |basket_item|

  		@product = Product.find(basket_item)
  		# on this order "o", add that product
  		o.order_products.build(product_id: @product.id, quantity: 1, price_in_pence: @product.price_in_pence)

  end

  # send back this order 
  return o

end

end
