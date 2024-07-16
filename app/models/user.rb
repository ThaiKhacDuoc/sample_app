class User < ApplicationRecord
  PERMITTED_ATTRIBUTES = [:name, :email, :password,
                          :password_confirmation].freeze
  has_secure_password

  validates :name, presence: true,
                   length: {maximum: Settings.maximum_name_length}

  validates :email, presence: true, uniqueness: true,
                    length: {maximum: Settings.maximum_email_length},
                    format: {with: Regexp.new(Settings.email_regex)}

  validates :password, presence: true,
                       length: {minimum: Settings.min_password_length}

  before_save {self.email = email.downcase}
end
