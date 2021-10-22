class Public::HomesController < ApplicationController
  def about
  end
  
  def top
    @items = Items.all
  end
end
