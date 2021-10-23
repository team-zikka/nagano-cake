class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
		@order_detail = OrderDetail.find(params[:id]) #IDを取得
		@order = @order_detail.order #注文詳細から注文テーブルの呼び出し
		@order_detail.update(order_detail_params) #　製作ステータスの更新

		if @order_detail.making_status == "製作中" #製作ステータスが「製作中」なら
			@order.update(order_status: 2) #注文ステータスを「製作中」に更新

	#上記の条件に当てはまらなければ、商品の個数の特定　　製作ステータスが「製作l完了」の商品をカウント
	#数が一致すれば、全ての商品の製作ステータスが「製作完了」だとわかる
		elsif @order.order_detail.count ==  @order.order_items.where(making_status: "製作完了").count
			@order.update(order_status: 3) #注文ステータスを「発送準備中]に更新
		end
		redirect_to admin_order_path(@order_item.order) #注文詳細に遷移
	end


	private

	  def order_item_params
      params.require(:order_detail).permit(:making_status)
    end

end
