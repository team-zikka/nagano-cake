class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @customer = current_customer
    if @customer.cart_items.blank?
      flash[:warning] = "※カートが空です"
      redirect_to cart_items_path
    else
      @order = Order.new
    end
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def confirm
    @cart_item = current_customer.cart_items
    @order = Order.new(order_params)
    #現在の登録住所
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name
    #登録した配送先を選択
    elsif params[:order][:address_option] == "1"
      @address_id = params[:order][:address_key].to_i
      @address = Address.find(@address_id)
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      #新規配送先入力
    elsif params[:order][:address_option] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end

    if @order.postal_code.blank? || @order.address.blank? || @order.name.blank?
      flash[:warning] = "※郵便番号・住所・宛名のすべてに入力してください"
      redirect_to new_order_path
    end

    @order.shipping_cost = 800
  end

  def create
    #注文のID
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    cart_items = current_customer.cart_items
     cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item.id
        @order_detail.item.name = cart_item.item.name
        @order_detail.price = cart_item.item.price
        @order_detail.amount = cart_item.amount
        @order_detail.save
     end
     current_customer.cart_items.destroy_all
     redirect_to complete_orders_path
  end

  def index
    @customer = current_customer
		@orders = @customer.orders.page(params[:page]).per(5).reverse_order
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :shipping_cost, :total_payment, :customer_id, :status)
  end
end