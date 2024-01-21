class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :following_user, class_name: 'User', foreign_key: 'following_user_id'
  belongs_to :followed_user, class_name: 'User', foreign_key: 'followed_user_id'
end
