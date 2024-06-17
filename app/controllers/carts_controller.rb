class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy ]

  # GET /carts or /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1 or /carts/1.json
  def show
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
    # begin
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
    # rescue => e
    #   respond_to do |format|
    #     flash.now[:alert] = "Something went worng"
    #     format.turbo_stream 
    #     format.html {
    #       render json: { message: "Failed to add item to cart: #{e.message}" }, status: :unprocessable_entity
    #     }
    #     format.json {render json: { message: "Failed to add item to cart" }, status: :unprocessable_entity}
    #   end
    # end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to cart_url(@cart), notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy!

    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:user_id, :total_price, :external_user_id)
    end

    def cart_product_params
      params.require(:cart).permit(:user_id, :total_price, :external_user_id, :product_id, :quantity, :price)
    end
end
