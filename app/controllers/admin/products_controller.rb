class Admin::ProductsController < Admin::BaseController 
  before_action :find_by_id_product, only: [:show, :edit, :update, :destroy]
  
  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by_id(params[:id])
  end
  
  def new
    @product = Product.new
  end

  def create
    @product.save
    redirect_to [:admin, @product]
  end

  def edit
  end

  def update
    @product = Product.find_by_id(params[:id])
    @product.update(product_params)
    redirect_to [:admin, @product]
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
    params.require(:product).permit(:name, :price, :description, :category_id)
  end


end
