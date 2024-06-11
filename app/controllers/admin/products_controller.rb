class Admin::ProductsController < Admin::BaseController 
  before_action :find_by_id_product, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumbs
  
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by_id(params[:id])
  end
  
  def new
    @product = Product.new
    breadcrumbs.add "new"
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to [:admin, @product]
  end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    @product = Product.find_by_id(params[:id])
    respond_to do |format|
      if @product.update(product_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@post, partial: "product/product", locals: {product: @product}) }
        format.html { redirect_to admin_products_path(@product), notice: "Product was successfully updated." }
      end
    end
  end

  def destroy 
    @product.destroy
    redirect_to admin_products_path
  end 

  private
  
  def find_by_id_product
    @product = Product.find_by_id(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :specification, :stock_quantity, :category_id, :product_images)
  end

  def add_breadcrumbs
    breadcrumbs.add "Admin"
    breadcrumbs.add "Products", admin_products_path
  end


end
