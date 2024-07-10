class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :add_breadcrumbs
  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
  end

  private
  def set_user
    @user = User.find_by_id(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number)
  end

  def add_breadcrumbs
    breadcrumbs.add "Home", :root_path
    breadcrumbs.add "Profile", :users_path
    breadcrumbs.add "Profile Information", user_path(current_user.id)
  end
end
