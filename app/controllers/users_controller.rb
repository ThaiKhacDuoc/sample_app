class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy User.all, items: Settings.pagy_items
  end

  def show
    @page, @microposts = pagy @user.microposts, items: Settings.page_10
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "sign_up.notification_mail"
      redirect_to root_url, status: :see_other
    else
      flash.now[:danger] = t("user_creation_failed")
      render :new, status: :unprocessable_entity
    end
  end

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

  def edit; end

  def following
    @title = t "follow.followings"
    @pagy, @users = pagy @user.following, items: Settings.page_10
    render :show_follow
  end

  def followers
    @title = t "follow.followers"
    @pagy, @users = pagy @user.followers, items: Settings.page_10
    render :show_follow
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
