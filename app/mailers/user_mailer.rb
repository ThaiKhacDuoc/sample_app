class UserMailer < ApplicationMailer
  def account_activation user
    @user = user

    mail to: user.email, subject: t("user_mailer.title")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("password_resets.title")
  end
end
