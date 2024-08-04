class Admin::UsersController < Admin::BaseController 
  before_action :set_user, only: [:edit, :update]
  before_action :add_breadcrumbs

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  # def edit_password
  # end

  # def update_password
  #   @user = User.find_by_id(params[:id])
  #   if @user.update(password_params)
  #     redirect_to admin_users_path
  #   else
  #     render :edit_password
  #   end
  # end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update  
    @user = User.find_by_id(params[:id])
    @user.update(user_params)           
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find_by_id(params[:id])
  end

  def add_breadcrumbs
    breadcrumbs.add "Users", admin_users_path
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number)    
  end
end
