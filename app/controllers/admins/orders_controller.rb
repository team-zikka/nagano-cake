class Admins::OrdersController < ApplicationController

	# before_action :authenticate_admin!

  def show
  	# IDごとの注文内容を取得
  	@order = Order.find(params[:id])
    # 注文内容の商品情報を取得
  	@order_details = @order.order_details
  end

  def update
		@order = Order.find(params[:id])
		if @order.update(order_params)
		   flash[:success] = "注文ステータスを変更しました"
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
