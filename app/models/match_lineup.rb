class MatchLineup < ApplicationRecord
    belongs_to :match
    belongs_to :user
    belongs_to :formation
    has_many :lineup_substitute_options, dependent: :destroy
    has_many :lineup_players
    has_many :substitute_players, through: :lineup_substitute_options, source: :substitute_player
    has_many :match_substitutions
end
