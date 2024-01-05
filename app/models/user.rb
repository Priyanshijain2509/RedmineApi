class User < ApplicationRecord
  has_secure_password
  has_many :projects, dependent: :destroy
  validates :email, presence: true, uniqueness: true

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable, :database_authenticatable
  # devise :registerable,
  #        :recoverable, :rememberable, :validatable, :confirmable

         # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
