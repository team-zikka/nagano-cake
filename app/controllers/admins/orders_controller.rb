class Admins::OrdersController < ApplicationController

	before_action :authenticate_admin!

  def show
  	@order = Order.find(params[:id])
  	@order_details = @order.order_details
  end

  def update
  	@order = Order.find(params[:id])
  	@order_details = @order.order_details
  	@order.update(order_params)
		if @order.status == "confirm"
      @order_details.each do |order_detail|
			order_detail.update(making_status: 1 )
      end
			redirect_to admins_order_path(@order)
		else
			render :show
		end
	end

  private

	def order_params
		  params.require(:order).permit(:status)
	end

end
