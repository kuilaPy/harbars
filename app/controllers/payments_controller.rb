class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:payment_success, :webhook]
  before_action :set_payment, only: %i[ show edit update destroy payment_success ]

  # GET /payments or /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1 or /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy!

    respond_to do |format|
      format.html { redirect_to payments_url, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def payment_success
    @payment.update(razorpay_params)
    redirect_to cart_path(id: 'review', payment_id: @payment.id), notice: "Payment was successfully completed."
  end

  def get_payment_status
    @payment = Payment.find_by(id: params[:id])
    _razorpay_payment = @payment.fetch_payment(@payment.razorpay_payment_id)
    if @payment.pending? && (_razorpay_payment.status == 'authorized' || _razorpay_payment.status == 'captured')
      @payment.authorize!
      @payment.reload
      if @payment.captured?
        render json: {message: @payment.status}, status: :ok 
      else
        render json: {message: 'not captured'}, status: :unprocessable_entity
      end
    else
      render json: {message: 'not captured'}, status: :unprocessable_entity
    end
  end

  def webhook
    webhook_secret = ENV[:WEBHOOK_SECRET]
    payload = request.body.read
    signature = request.env['HTTP_X_RAZORPAY_SIGNATURE']
    if verify_signature(payload, signature, webhook_secret) && params[:payload].present? && params[:payload][:payment].present? && params[:payload][:payment][:entity].present?
      data = params[:payload][:payment][:entity]
      case params[:event]
      when 'payment.captured'
      when 'payment.failed'
      when 'payment.authorized'
        @payment = Payment.find_by(razorpay_payment_id: data[:id])
        # @payment.authorize! if @payment.present?
      end
      render plain: "Webhook success", status: 200
    else
      render plain: 'Signature mismatch', status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def verify_signature(payload, signature, secret)
      digest = OpenSSL::Digest.new('sha256')
      expected_signature = OpenSSL::HMAC.hexdigest(digest, secret, payload)
      signature == expected_signature
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:order_id, :amount, :payment_method, :status)
    end

    def razorpay_params
      params.permit(:razorpay_payment_id, :razorpay_order_id, :razorpay_signature)
    end
end
