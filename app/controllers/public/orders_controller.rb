class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.delivery_addresses
  end

  def confirm
   @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_address = current_customer.address
      @order.delivery_address_name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = DeliveryAddress.find(params[:order][:delivery_address_id])
      @order.delivery_postal_code = @address.postal_code
      @order.delivery_address = @address.address
      @order.delivery_address_name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.customer_id = current_customer.id
    end
      @cart_items = current_customer.cart_items
      @total = 0
      @order_new = Order.new
      render :confirm
  end
  
  def create
    @order = Order.new(order_params)
    @order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = @order.id
      @order_details.item_id = cart_item.item.id
      @order_details.purchase_price = cart_item.item.without_tax_price
      @order_details.quantity = cart_item.quantity
      @order_details.production_status = 0
      @order_details.save!
    end
    CartItem.destroy_all
    redirect_to orders_completion_path
  end

  def completion
  end

  def index
    @orders = Order.all
    @cart_items = current_customer.cart_items
  end

  def show
    @order_details = OrderDetail.where(order_id: params[:id])
    @order = Order.find(params[:id])
    @cart_items = current_customer.cart_items
    @total = 0
    @order_new = Order.new
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :delivery_postal_code, :delivery_address, :delivery_address_name, :customer_id , :status, :total_price, :postage)
    
  end

  def cartitem_nill
    cart_items = current_customer.cart_items
    if cart_items.blank?
      redirect_to cart_items_path
    end
  end
end
