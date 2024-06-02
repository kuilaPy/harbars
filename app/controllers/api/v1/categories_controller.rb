class Api::V1::CategoriesController < Api::ApiBaseController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /api/v1/categories
  def index
    @categories = Category.all
    render :index
  end

  # GET /api/v1/categories/:id
  def show
    render :show
  end

  # POST /api/v1/categories
  def create
    @category = Category.new(category_params)
    if @category.save
      render :show, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/categories/:id
  def update
    if @category.update(category_params)
      render :show
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/categories/:id
  def destroy
    @category.destroy
    head :no_content
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
