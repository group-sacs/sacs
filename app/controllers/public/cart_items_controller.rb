class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  #before_action :set_cart_item, only: %i[ destroy]

  def index
    @cart_items = current_customer.cart_items
  if @cart_items.blank?  # Check if cart_items is empty
    @empty_cart = true
  else
    @empty_cart = false
  end
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
  def destroy_all
   current_customer.cart_items.destroy_all
   redirect_to request.referer
  end
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to request.referer
  end
  
  private

  # def set_cart_item
  #   @cart_item = current_customer.cart_items.find(params[:id])
  # end

  def increase_or_create(item_id)
    cart_item = current_customer.cart_items.find_by(item_id:)
    if cart_item
      cart_item.quantity += params[:cart_item][:quantity].to_i
    else
     cart_item = CartItem.new(cart_item_params.merge(customer_id: current_customer.id))
    end
    cart_item.save#saveするときにはストロングパラメータを使う！！！
  end
  def cart_item_params
   params.require(:cart_item).permit(:item_id, :customer_id,:quantity)
  end
end