class User < ApplicationRecord
  has_one :account
  before_validation { email&.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end

  def subscriptions
    account.subscriptions
  end

  def active_subscriptions
    account.active_subscriptions
  end

  def cancelled_subscriptions
    account.cancelled_subscriptions
  end
end
