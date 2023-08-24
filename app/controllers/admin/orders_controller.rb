class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_details = OrderDetail.where(order_id: @order)
    # 関連する注文詳細情報（OrderDetail）を取得しています。
    # 特定の注文に関連する注文詳細情報を取得するために、
    # order_idカラムを使用してクエリを実行しています。取得した情報は@order_details変数に格納されます。
    @production_status = @order.order_details.pluck(:production_status)
    # このコードは、特定の注文に関連する注文詳細情報のproduction_statusカラムの値を取得して、それを@production_status変数に格納しています。
    # pluckメソッドは指定したカラムの値を取得するためのメソッドです。
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    # 特定の注文に関連する注文詳細情報を取得するためのクエリを実行しています。
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
