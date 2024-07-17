class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update destroy)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy User.all, items: Settings.pagy_items
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t("user_created_successfully")
      redirect_to @user
    else
      flash.now[:danger] = t("user_creation_failed")
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user&.update user_params
      flash[:success] = t("user_update_successfully")
      redirect_to @user
    else
      flash.now[:danger] = t("user_update_failed")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("user_deleted_successfully")
    else
      flash[:danger] = t("user_delete_failed")
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(User::PERMITTED_ATTRIBUTES)
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    redirect_to root_path unless @user
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t("please_log_in")
    store_location
    redirect_to login_path
  end

  def correct_user
    return if current_user? @user

    flash[:error] = t("error.user_not_correct")
    redirect_to root_path
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = t("error.user_not_admin")
    redirect_to root_path
  end
end
