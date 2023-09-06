class User < ApplicationRecord
    has_many :follows
    has_many :followed_users, through: :follows, source: :followed_user
    has_many :followed_by_users, through: :follows, source: :followed_by_user
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    has_secure_password
    has_one_attached :user_photo
end
