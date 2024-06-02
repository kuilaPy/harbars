class Api::V1::QuestionsController < Api::ApiBaseController
  before_action :set_question, only: [:show, :update, :destroy]

  # GET /api/v1/questions
  def index
    @questions = Question.all
    render :index
  end

  # GET /api/v1/questions/:id
  def show
    render :show
  end

  # POST /api/v1/questions
  def create
    @question = Question.new(question_params)
    if @question.save
      render :show, status: :created
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/questions/:id
  def update
    if @question.update(question_params)
      render :show
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/questions/:id
  def destroy
    @question.destroy
    head :no_content
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :description, :user_id)
  end
end
