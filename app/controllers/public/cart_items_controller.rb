class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: %i[increase decrease destroy]

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    increase_or_create(params[:cart_item][:item_id])
    redirect_to cart_items_path
  end
  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      render :index
    end
  end
  def increase
    @cart_item.increment!(:quantity, 1)
    redirect_to request.referer
  end

  def decrease
    decrease_or_destroy(@cart_item)
    redirect_to request.referer, notice
  end

  def destroy
    @cart_item.destroy
    redirect_to request.referer
  end

  private

  def set_cart_item
    @cart_item = current_customer.cart_items.find(params[:id])
  end

  def increase_or_create(item_id)
    cart_item = current_customer.cart_items.find_by(item_id:)
    if cart_item
      cart_item.quantity += params[:cart_item][:quantity].to_i
    else
     cart_item = CartItem.new(cart_item_params.merge(customer_id: current_customer.id))
    end
    cart_item.save#saveするときにはストロングパラメータを使う！！！
  end

 
 private 
  def cart_item_params
   params.require(:cart_item).permit(:item_id, :customer_id,:quantity)
  end
end