class League < ApplicationRecord
  belongs_to :user
  has_many :matches, dependent: :destroy, foreign_key: 'league_id', inverse_of: :league, counter_cache: true, through: :league_groups
  has_many :game_weeks, dependent: :destroy, through: :league_groups
  has_many :league_groups
  has_many :teams, dependent: :destroy, through: :league_groups
  has_many :players, through: :teams
  has_many :match_lineups, through: :matches
  has_many :trophies, through: :teams
end
