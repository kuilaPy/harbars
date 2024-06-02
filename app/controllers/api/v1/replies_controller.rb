class Api::V1::RepliesController < Api::ApiBaseController
  before_action :set_reply, only: [:show, :update, :destroy]

  # GET /api/v1/replies
  def index
    @replies = Reply.all
    render :index
  end

  # GET /api/v1/replies/:id
  def show
    render :show
  end

  # POST /api/v1/replies
  def create
    @reply = Reply.new(reply_params)
    if @reply.save
      render :show, status: :created
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/replies/:id
  def update
    if @reply.update(reply_params)
      render :show
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/replies/:id
  def destroy
    @reply.destroy
    head :no_content
  end

  private

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:comment_id, :user_id, :content)
  end
end
