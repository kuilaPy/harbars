class Api::V1::AddressesController < Api::ApiBaseController
  before_action :set_address, only: [:show, :update, :destroy]

  # GET /api/v1/addresses
  def index
    @addresses = Address.all
    render :index
  end

  # GET /api/v1/addresses/:id
  def show
    render :show
  end

  # POST /api/v1/addresses
  def create
    @address = Address.new(address_params)
    if @address.save
      render :show, status: :created
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/addresses/:id
  def update
    if @address.update(address_params)
      render :show
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/addresses/:id
  def destroy
    @address.destroy
    head :no_content
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:user_id, :street, :city, :state, :zip)
  end
end
