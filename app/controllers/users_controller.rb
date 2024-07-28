class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :edit_password]
  before_action :add_breadcrumbs
  def show
    breadcrumbs.add "Profile Information", user_path(current_user.id)
  end

  def edit
  end

  def update
    @user.update(user_params)
  end

  def edit_password
    breadcrumbs.add "Change Password", edit_user_password_path(current_user.id)
  end

  def update_password
    if current_user.update(password_params)
      redirect_to root_path, notice: 'Password was successfully updated.'
    else
      render :edit_password
    end
  end

  private
  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number)
  end
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def add_breadcrumbs
    breadcrumbs.add "Home", :root_path
    breadcrumbs.add "Profile", :users_path
  end
end
