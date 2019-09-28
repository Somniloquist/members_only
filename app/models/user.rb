class User < ApplicationRecord
  before_create :generate_remember_token
  before_save :downcase_email
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private
    def downcase_email
      self.email.downcase!
    end

    def generate_remember_token
      remember_token =  SecureRandom.urlsafe_base64.to_s
      self.remember_token = Digest::SHA1.hexdigest(remember_token)
    end
end
