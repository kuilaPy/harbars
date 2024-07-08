class CartsController < ApplicationController
  include Wicked::Wizard
  before_action :authenticate_user!, only: [:checkout, :show]
  before_action :set_cart, only: %i[ edit destroy]

  steps :user_details, :order_address, :place_order, :payment, :review

  # GET /carts or /carts.json
  def index
    @cart = Cart.find_by(external_user_id: params[:external_id])
    @cart_items = @cart.cart_items
  end

  # GET /carts/1 or /carts/1.json
  def show
    @cart = Cart.find_by(external_user_id: current_user.external_user_id)
    @cart_items = @cart.cart_items
    case step
    when :user_details
    when :order_address
    when :place_order
    when :payment
      @payment = @cart.payment
    when :review
      @payment = Payment.find_by(id: params[:payment_id])
      @order = @payment.order
      @order.get_expect_delivery_date unless @order.expected_delivery_date.present?
    end
    render_wizard
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts or /carts.json
  def create
    begin
      @cart = Cart.find_by(external_user_id: cart_product_params[:external_user_id])
      @cart = Cart.new(cart_params) unless @cart.present?
      if @cart.save
        @cart_prod = @cart.cart_items.find_by(product_id: cart_product_params[:product_id])
        if @cart_prod.present?
          @cart_prod.update_columns(quantity: @cart_prod.quantity + 1, price: @cart_prod.product.price * @cart_prod.quantity + 1 )
        else
          @cart_prod = @cart.cart_items.new(cart_product_params)
          @cart_prod.quantity =  1
          @cart_prod.price = @cart_prod.product.price
          @cart_prod.save
        end
      end
      respond_to do |format|
        format.turbo_stream 
        format.html
        format.json {render json: { message: "Add item to cart" }, status: 200}
      end
    rescue => e
      respond_to do |format|
        flash.now[:alert] = "Something went worng"
        format.turbo_stream 
        format.html {
          render json: { message: "Failed to add item to cart: #{e.message}" }, status: :unprocessable_entity
        }
        format.json {render json: { message: "Failed to add item to cart" }, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    @cart = Cart.find_by(external_user_id: current_user.external_user_id)
    case step
    when :user_details
      current_user.update(user_params)
    when :order_address
      shipping_address = current_user.addresses.where(id: order_params[:shipping_address_id])
      shipping_address.update(is_default: true)
    when :place_order
      @payment = current_user.payments.new(amount: @cart.total_price * 1.18, payment_method: 'online', status: 'pending', cart_id: @cart.id)
      if @payment.save
        redirect_to next_wizard_path(payment_id: @payment.id) and return
      else
        redirect_to wizard_path, alert: @payment.errors.full_messages.to_sentence and return
      end
    when :payment
      # default_address = current_user.default_address
      # current_user.orders.create(status: 'initiate', total_price: @cart.total_price, total_with_gst: @cart.total_price * 1.18, shipping_address_id: default_address.id, billing_address: default_address.id)
    when :review
    end
    render_wizard @cart
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy!

    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def checkout
  end

  def finish_wizard_path
    product_path(product)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end


    def user_params 
      params.require(:user).permit(:email, :first_name, :last_name, :phone_number)
    end

    def order_params
      params.require(:order).permit(:shipping_address_id)
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:user_id, :total_price, :external_user_id)
    end

    def cart_product_params
      params.require(:cart).permit(:user_id, :total_price, :external_user_id, :product_id, :quantity, :price)
    end
end
