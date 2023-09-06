class MatchLineup < ApplicationRecord
    belongs_to :match
    belongs_to :user
    belongs_to :formation
    has_many :lineup_substitute_options
    has_many :lineup_players
    has_many :match_substitutions
end
