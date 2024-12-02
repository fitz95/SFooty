class LineupPlayer < ApplicationRecord
    belongs_to :match
    belongs_to :team
    belongs_to :formation
    belongs_to :user
    belongs_to :player
    belongs_to :lineup_position
    has_many :lineup_players, dependent: :destroy, foreign_key: :match_lineup_id, inverse_of: :match_lineup, counter_cache: true
    has_many :lineup_substitute_options, dependent: :destroy
    has_many :match_substitutions, dependent: :destroy
end

