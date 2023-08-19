class Admin::OrdersController < ApplicationController
  before_action :authenticate_member!
  
  def new
    @order = Order.new
    @addresses = current_customer.addresses.a
  end
  
  def show
  end
end
