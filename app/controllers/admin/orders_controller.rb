class Admin::OrdersController < ApplicationController
  before_action :find_by_id_order, only: [:show, :edit, :update, :destroy]
  
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find_by_id(params[:id])
  end
  
  def new
    @order = Order.new
  end

  def create
    @order.save
    redirect_to [:admin, @order]
  end

  def edit
  end

  def update
    @order = Order.find_by_id(params[:id])
    @order.update(order_params)
    redirect_to [:admin, @order]
  end

  def destroy 
    @order.destroy
    redirect_to admin_orders_path
  end 

  private
  
  def find_by_id_order
    @order = Order.find_by_id(params[:id])
  end

  def order_params
    params.require(:order).permit(:order_number, :user_id, :order_status_id)
  end
end
