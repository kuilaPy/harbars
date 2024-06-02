class Api::V1::CartsController < Api::ApiBaseController
  before_action :set_cart, only: [:show, :update, :destroy]

  # GET /api/v1/carts
  def index
    @carts = Cart.all
    render :index
  end

  # GET /api/v1/carts/:id
  def show
    render :show
  end

  # POST /api/v1/carts
  def create
    @cart = Cart.new(cart_params)
    if @cart.save
      render :show, status: :created
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/carts/:id
  def update
    if @cart.update(cart_params)
      render :show
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/carts/:id
  def destroy
    @cart.destroy
    head :no_content
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.require(:cart).permit(:user_id, :creation_date)
  end
end
