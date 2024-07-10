class AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update destroy ]
  before_action :add_breadcrumbs

  # GET /addresses or /addresses.json
  def index
    @addresses = Address.all
  end

  # GET /addresses/1 or /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  def new_order_address
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses or /addresses.json
  def create
    @address = current_user.addresses.new(address_params)
    respond_to do |format|
      if @address.save
        # format.html { redirect_to cart_path(id: 'order_address'), notice: "Address was successfully created." }
        format.turbo_stream 
        format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_order_address
    @address = current_user.addresses.new(address_params)
    if @address.save
      redirect_to cart_path(id: 'order_address'), notice: "Address was successfully created."
    else
      render :new_order_address
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to address_url(@address), notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy!

    respond_to do |format|
      format.html { redirect_to addresses_url, notice: "Address was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find_by_id(params[:id])
    end

    def add_breadcrumbs
      breadcrumbs.add "Home", :root_path
      breadcrumbs.add "Profile", :users_path
      breadcrumbs.add "Manage Addresses", :addresses_path
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:user_id, :name, :address_line_1, :address_line_2, :contact_number, :city, :state, :zip_code, :country, :address_type)
    end
end
