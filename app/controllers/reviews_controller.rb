class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :set_product, only: %i[show new  edit update destroy ]

  # before_action :set_or_get_review, only: [:create]

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
    @product = Product.find(params[:product_id])
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params) 
    @product = @review.product
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to order_url(id: @review.order_id), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy!

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:product_id, :user_id, :rating, :comment, :order_id)
    end
end
