class Api::V1::ProductsController < Api::ApiBaseController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /api/v1/products
  def index
    @products = Product.all
    render :index
  end

  # GET /api/v1/products/:id
  def show
    render :show
  end

  # POST /api/v1/products
  def create
    @product = Product.new(product_params)
    if @product.save
      render :show, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/products/:id
  def update
    if @product.update(product_params)
      render :show
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock_quantity, :category_id)
  end

end
