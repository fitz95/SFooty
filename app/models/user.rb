class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :follows
  has_many :followed_users, through: :follows, source: :followed_user
  has_many :followed_by_users, through: :follows, source: :followed_by_user
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true
  # has_secure_password
  # has_one_attached :user_photo

  # Example: A scope to find users with a specific role
  scope :by_role, ->(role) { where(role: role) }
end
