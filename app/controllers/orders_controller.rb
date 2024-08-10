class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[ show edit update destroy invoice cancel]

  # GET /orders or /orders.json
  def index
    # @orders = Order.all
    @orders = current_user.orders
  end

  # GET /orders/1 or /orders/1.json
  def show
    @refund = @order.refund
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def invoice
    respond_to do |format|
      format.pdf { send_pdf }
    end
  end

  def cancel
    if @order.cancel!
      redirect_to @order, notice: "Order Canceled"
    else
      redirect_to @order, alert: "Order is not canceled"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def send_pdf
      r = @order.generate_invoice
      # Render the PDF in memory and send as the response
      send_data r.render,
        filename: "#{@order.order_reference}-receipt.pdf",
        type: "application/pdf",
        disposition: "attachment"
        # disposition: :inline # or :attachment to download
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id, :total_price, :status)
    end
end
