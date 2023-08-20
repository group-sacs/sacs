class Public::DeliveryAddressesController < ApplicationController
  before_action :authenticate_user!
  def index
    @delivery = Delivery.find(params[:id])#インスタンス変数はどうする？
    if @delivery.customer == current_customer
      render "index"#配送先一覧ページ
    @deliverys = DeliveryAddress.all
    @user =current_customer#ログインしているユーザ
    @delivery= DeliveryAddress.new
  end

  def edit
     @delivery = Delivery.find(params[:id])
    if @delivery.customer == current_customer
      render "edit"#配送先の編集ページ
    else
      redirect_to delivery_index_path#配送先の一覧に戻る
    end
  end
  
  def create
     @delivery = DeliveryAddress.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      redirect_to delivery_path(@delivery)#ユーザ配達情報維持したままどこに移動する？
    else
      @deliverys = DeliveryAddress.all
      @user = current_customer
      render 'index'
    end
  end
  
  def update
   @delivery = DeliveryAddress.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to delivery_path(@delivery)#どこに行く？一覧にしとく
    else
      render "edit"
    end
 
  def destroy
    delivery = DeliveryAddress.find(params[:id])
    deliveryAddress.destroy
    redirect_to deliverys_path#一覧に飛ぶ？
  end
  
  end
    
end
#途中