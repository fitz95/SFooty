class MatchGoal < ApplicationRecord
    belongs_to :match
    belongs_to :assister_player_id, class_name: "Player", foreign_key: "assist_player_id", optional: true
    belongs_to :scorer_player_id, class_name: "Player", foreign_key: "scorer_player_id", optional: true
    belongs_to :team_for_id, class_name: "Team", foreign_key: "team_for_id"
    belongs_to :team_against_id, class_name: "Team", foreign_key: "team_against_id"
    belongs_to :user
end
