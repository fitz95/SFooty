class GameWeek < ApplicationRecord
  belongs_to :league
  belongs_to :user
  belongs_to :league_group, optional: true
  has_many :matches, dependent: :destroy, foreign_key: 'game_week_id', inverse_of: :game_week,
                     counter_cache: :matches_count
end
