class SessionsController < ApplicationController
  before_action :find_user_by_email, only: :create
  def new; end

  def create
    if @user&.authenticate params.dig(:session, :password)
      if @user.activated
        log_in @user
        params.dig(:session, :remember_me) == "1" ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        flash[:warning] = t "sessions.create.not_activated"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "sessions.create.invalid"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  def find_user_by_email
    @user = User.find_by(email: params.dig(:session, :email)&.downcase)
  end
end
