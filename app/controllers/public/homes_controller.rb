class Public::HomesController < ApplicationController
  def about
  end

  def top
    @genres = Genre.all
    @items = Item.limit(4).order(:created_time)
  end
end
