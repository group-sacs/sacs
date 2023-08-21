class Public::ItemsController < ApplicationController
  def index
    @items = get_item(params)
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def get_item(params)
    return Item.all, 'default' unless params[:latest] || params[:price_high_to_low] || params[:price_low_to_high]

    return Item.latest, 'latest' if params[:latest]

    return Item.price_high_to_low, 'price_high_to_low' if params[:price_high_to_low]

    return Item.price_low_to_high, 'price_low_to_high' if params[:price_low_to_high]
  end
end

