class MatchSubstitution < ApplicationRecord
    belongs_to :match
    belongs_to :user
    belongs_to :substitution_player_in, class_name: "Player", foreign_key: "substitution_player_in_id"
    belongs_to :substitution_player_out, class_name: "Player", foreign_key: "substitution_player_out_id"
end
