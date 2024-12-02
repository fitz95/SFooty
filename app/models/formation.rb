class Formation < ApplicationRecord
  belongs_to :user
  has_many :lineup_positions, dependent: :destroy, foreign_key: :formation_id, inverse_of: :formation,
                              counter_cache: true
  has_many :match_lineups, dependent: :destroy
end
