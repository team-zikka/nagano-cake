class Public::OrdersController < ApplicationController

  def new
    @customer = current_customer
  end

  def confirm
    @item = Item.find(params[:item_id])
    @order_item = @item.oeder.new(order_params)
  end
end