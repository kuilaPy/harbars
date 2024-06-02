class Api::V1::PaymentsController < Api::ApiBaseController
  before_action :set_payment, only: [:show, :update, :destroy]

  # GET /api/v1/payments
  def index
    @payments = Payment.all
    render :index
  end

  # GET /api/v1/payments/:id
  def show
    render :show
  end

  # POST /api/v1/payments
  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      render :show, status: :created
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/payments/:id
  def update
    if @payment.update(payment_params)
      render :show
    else
      render json: @payment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/payments/:id
  def destroy
    @payment.destroy
    head :no_content
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:order_id, :payment_date, :amount)
  end
end
