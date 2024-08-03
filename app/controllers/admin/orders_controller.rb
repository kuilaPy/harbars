class Admin::OrdersController < Admin::BaseController 
  before_action :find_by_id_order, only: [:show, :edit, :update, :destroy, :confirm_order, :update_confirmed_order]
  before_action :add_breadcrumbs
  
  def index
    @orders = Order.all
    @orders = @orders.order(created_at: :desc)
    # breadcrumbs.add "Orders", admin_orders_path
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

  def update_confirmed_order
    if @order.update(order_params)
      redirect_to admin_orders_path
    else
      render :confirm_order
    end
  end

  private
  
  def find_by_id_order
    @order = Order.find_by_id(params[:id])
  end

  def add_breadcrumbs
    breadcrumbs.add "Orders", admin_orders_path
  end

  def order_params
    params.require(:order).permit(:order_number, :user_id, :order_status_id, :status, :shipped_at, :length, :width, :height, :weight)
  end
end
