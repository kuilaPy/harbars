class Api::V1::ReviewsController < Api::ApiBaseController
  before_action :set_review, only: [:show, :update, :destroy]

  # GET /api/v1/reviews
  def index
    @reviews = Review.all
    render :index
  end

  # GET /api/v1/reviews/:id
  def show
    render :show
  end

  # POST /api/v1/reviews
  def create
    @review = Review.new(review_params)
    if @review.save
      render :show, status: :created
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/reviews/:id
  def update
    if @review.update(review_params)
      render :show
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/reviews/:id
  def destroy
    @review.destroy
    head :no_content
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:product_id, :user_id, :rating, :content)
  end
end
