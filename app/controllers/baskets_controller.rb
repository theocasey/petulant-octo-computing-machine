class BasketsController < ApplicationController

	def create
		# add this product to the basket

		# :product_id because we're in a nested resource
		# so not :id because we're not talking about a basket
		@product = Product.find(params[:product_id])

		# let's add this product id to the basket
		basket.add(@product.id)

		# let's tell the user
		flash[:success] = "Item added to basket"

		# go back to the product show page
		redirect_to product_path(@product)
	end

	def destroy
		# remove this product from the basket
		@product = Product.find(params[:product_id])

		basket.delete(@product.id)

		flash[:success] = "Item removed from basket"

		redirect_to product_path(@product)
	end

end









