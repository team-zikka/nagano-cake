class Admins::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
		@order_detail = OrderDetail.find(params[:id])
		@order = @order_detail.order
		@order_detail.update(order_detail_params)

    if @order.order_details.count ==  @order.order_details.where(making_status: 3).count
		 @order.update(status: 3)
		else @order_detail.making_status == "makeing_now"
		 @order.update(status: 2)
		end
		redirect_to admins_order_path(@order_detail.order)
  end

	private

	  def order_detail_params
      params.require(:order_detail).permit(:making_status)
    end

end
