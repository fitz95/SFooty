class League < ApplicationRecord
  belongs_to :user
  has_many :matches, dependent: :destroy, foreign_key: 'league_id', inverse_of: :league, counter_cache: : true
  has_many :game_weeks, dependent: :destroy
end
