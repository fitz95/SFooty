class LineupSubstituteOption < ApplicationRecord
    belongs_to :substitute_player, class_name: "Player", foreign_key: "substitute_player_id"
    belongs_to :team
    belongs_to :user
    belongs_to :match_lineup
end
