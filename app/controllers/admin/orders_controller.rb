class Admin::OrdersController < Admin::BaseController 
  before_action :find_by_id_order, only: [:show, :edit, :update, :destroy]
  # before_action :add_breadcrumbs
  
  def index
    @orders = Order.all
    breadcrumbs.add "Orders", admin_orders_path
  end

  def show
    @order = Order.find_by_id(params[:id])
    breadcrumbs.add "Order Deatils", admin_order_path(@order)
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

  def confirm_order
    
  end

  private
  
  def find_by_id_order
    @order = Order.find_by_id(params[:id])
  end

  # def add_breadcrumbs
  #   breadcrumbs.add "Admin"
  #   breadcrumbs.add "Orders", admin_orders_path
  # end

  def order_params
    params.require(:order).permit(:order_number, :user_id, :order_status_id)
  end
end
