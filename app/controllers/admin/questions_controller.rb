class Admin::QuestionsController < Admin::BaseController 
  before_action :set_admin_question, only: %i[ show edit update destroy ]

  # GET /admin/questions or /admin/questions.json
  def index
    @questions = Question.all.order(created_at: :desc)
    # @questions = Question.left_joins(:reply).group(:id).having('count(replies.id) = 0')
  end

  # GET /admin/questions/1 or /admin/questions/1.json
  def show
  end

  # GET /admin/questions/new
  def new
    @question = Question.new
  end

  # GET /admin/questions/1/edit
  def edit
    @question.build_reply if @question.reply.nil?
  end

  # POST /admin/questions or /admin/questions.json
  def create
    @question = Question.new(admin_question_params)

    respond_to do |format|
      if @admin_question.save
        format.html { redirect_to admin_question_url(@admin_question), notice: "Question was successfully created." }
        format.json { render :show, status: :created, location: @admin_question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/questions/1 or /admin/questions/1.json
  def update
    respond_to do |format|
      if @question.update(admin_question_params)
        format.html { redirect_to admin_question_url(@admin_question), notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_question }
        format.turbo_stream do
          flash.now[:notice] = "Updated!"
          render turbo_stream: turbo_stream.replace("question-#{@question.id}", partial: "admin/questions/question", locals: { question: @question })
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/questions/1 or /admin/questions/1.json
  def destroy
    @admin_question.destroy!

    respond_to do |format|
      format.html { redirect_to admin_questions_url, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_question_params
      params.require(:question).permit(reply_attributes: [:content, :id, :user_id, :question_id])
    end
end
