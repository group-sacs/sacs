class Public::DeliveryAddressesController < ApplicationController
  before_action :authenticate_customer!
  def index
 
    @deliverys = current_customer.delivery_addresses
    #@customer =current_customer#ログインしているユーザいらない
    @delivery= DeliveryAddress.new
  end

  def edit
    @delivery = DeliveryAddress.find(params[:id])#ID番号が表示されてないからアクティブレコードが起きている。

  end

  def create
     @delivery = DeliveryAddress.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      redirect_to delivery_addresses_path#ユーザ配達情報維持したままどこに移動する？
    else
      @deliverys = DeliveryAddress.all
      @user = current_customer
      render :index
    end
  end

  def update
   @delivery = DeliveryAddress.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to delivery_addresses_path#どこに行く？一覧にしとく
    else
      render :edit  #配送先の編集ページ
    end
  end

  def destroy
    @delivery = DeliveryAddress.find(params[:id])
    @delivery.destroy
    redirect_to delivery_addresses_path
  end

   private

  def delivery_params
    params.require(:delivery_address).permit(:postal_code, :address, :name)
  end

end
#途中