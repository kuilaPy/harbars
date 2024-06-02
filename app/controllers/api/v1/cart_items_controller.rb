class Api::V1::CartItemsController < Api::ApiBaseController
  before_action :set_cart_item, only: [:show, :update, :destroy]

  # GET /api/v1/cart_items
  def index
    @cart_items = CartItem.all
    render :index
  end

  # GET /api/v1/cart_items/:id
  def show
    render :show
  end

  # POST /api/v1/cart_items
  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      render :show, status: :created
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/cart_items/:id
  def update
    if @cart_item.update(cart_item_params)
      render :show
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/cart_items/:id
  def destroy
    @cart_item.destroy
    head :no_content
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:cart_id, :product_id, :quantity)
  end
end
