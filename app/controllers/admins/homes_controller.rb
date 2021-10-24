class Admins::HomesController < ApplicationController

   before_action :authenticate_admin!

  def top
    @order = Order.find_by(id: params[:id])
    @orders = Order.all #ID同士を紐づける
  end
end
