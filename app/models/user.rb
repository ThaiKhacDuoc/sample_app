class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true,
length: {maximum: Rails.application.config.maximum_name_length}

  validates :email, presence: true, uniqueness: true,
length: {maximum: Rails.application.config.maximum_email_length},
format: {with: Rails.application.config.email_regex}

  validates :password, presence: true,
length: {minimum: Rails.application.config.min_password_length}

  before_save{self.email = email.downcase}
end
