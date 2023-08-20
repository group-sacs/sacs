class Public::ItemsController < ApplicationController
 before_action :authenticate_admin!#運営がはログインすみのみ表示
  before_action :set_item only[:new, :create, :edit, :update]#これどういう意味

  def index
    @Items = Item.all
  end

  def new
    @item = Items.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)#koredousuru?パスなくない？
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  private

  def set_product#これ何？
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:item).permit(:name, :explamatory_text, :without_tax_price, :is_sales_status)
  end
end
end
