class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_details = OrderDetail.where(order_id: @order)
    @production_status = @order.order_details.pluck(:production_status)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    if @order.update(order_params)
       @order_details.update_all(production_status: 1) if @order.status == "confirm_payment"
      # "confirm_payment"「入金確認」
       ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
    end
      redirect_to admin_order_path(@order)
  end


private

  def order_params
    params.require(:order).permit(:status)
  end

end
