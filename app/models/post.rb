class Post < ApplicationRecord
  belongs_to :user
  belongs_to :team, optional: true
  belongs_to :league, optional: true
  belongs_to :player, optional: true
  belongs_to :match, optional: true

  # Example: A scope to find published posts
  scope :published, -> { where(status: 'published') }
end
