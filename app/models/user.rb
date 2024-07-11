class User < ApplicationRecord
  before_save{email.downcase!}
  has_secure_password

  validates :name, presence: true,
                   length: {maximum: Settings.maximum_name_length}

  validates :email, presence: true, uniqueness: true,
                    length: {maximum: Settings.maximum_email_length},
                    format: {with: Settings.application.config.email_regex}

  validates :password, presence: true,
                       length: {minimum: Settings.min_password_length}
end
