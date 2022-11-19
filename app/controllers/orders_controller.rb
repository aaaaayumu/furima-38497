class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :move_to_root, only: :index

  def index
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new(order_params)
    if @order_shipping_address.valid?
      @order_shipping_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_shipping_address).permit(:postcode, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def move_to_root
    return redirect_to root_path if current_user.id == Item.find(params[:item_id]).user.id
    return redirect_to root_path if Item.find(params[:item_id]).order.present?
  end
end
