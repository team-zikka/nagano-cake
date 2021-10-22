class Public::CartItemsController < ApplicationController
  def  index
    @cart_items = current_customer.cart_items
  end

  def  create
    if @cart_item.blank?
       #@cart_item = current_customer.cart_items.new(cart_item_params)
       @cart_item = current_customer.cart_items.new(params_cart_item)
       #@cart_item = current_customer.cart_items.new(item_id: params[:item_id])
       @cart_item.update(amount: params[:cart_item][:amount].to_i)
    end
       @cart_item.amount += params[:amount].to_i
       @cart_item.save
       redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: params[:cart_item][:amount].to_i)
    #@cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_item = current_customer.cart_items
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  private

  def params_cart_item
    params.require(:cart_item).permit(:amount, :item_id)
  end
end