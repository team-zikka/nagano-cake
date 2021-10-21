class Admin::CustomersController < ApplicationController
<<<<<<< Updated upstream
=======

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

>>>>>>> Stashed changes
end
