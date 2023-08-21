class Admin::OrdersController < ApplicationController
  before_action :authenticate_member!
  
  def index
    @orders = Order.all
  end
  
  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
       @address = Address.find(params[:order][:address_id])
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.customer_id = current_customer.id
    end
      @cart_items = current_customer.cart_items
      @order_new = Order.new
      render :confirm
  end
  
  def create
    order = Order.new(order_params)
    order.save
    @cart_items = current_customer.cart_items.all
    
    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item.id
      @order_details.price = cart_item.item.price_excluding_tax
      @order_details.number = cart_item.amount
      @order_details.manufacture_status = 0
      @order_details.save!
    end
    
    CartItem.destroy_all
    redirect_to orders_completion_path

  end
      
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end
  
  def show
    @order_details = OrderDetail.where(order_id: params[:id])
    @order = Order.find(params[:id])
  end
  
  private
    def order_params
      params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :amount_requested, :end_user_id , :order_status)
    end
    
    def cartitem_nill
      cart_items = current_customer.cart_items
      if cart_items.blank?
        redirect_to cart_items_path
      end
    end
end
