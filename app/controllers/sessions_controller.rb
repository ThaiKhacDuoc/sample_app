class SessionsController < ApplicationController
  before_action :find_user, only: [:create]

  def new; end

  def create
    if @user&.authenticate(params.dig(:session, :password))
      log_in @user
      params.dig(:session, :remember_me) == "1" ? remember(@user) : forget(@user)
      redirect_to @user
    else
      flash.now[:danger] = t "sessions.create.invalid"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  def find_user
    @user = User.find_by email: params.dig(:session, :email)&.downcase
    return if @user

    flash.now[:danger] = t "sessions.create.invalid"
    render :new, status: :unprocessable_entity
  end
end
