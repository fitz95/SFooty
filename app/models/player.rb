class Player < ApplicationRecord
    belongs_to :user
    belongs_to :current_team, class_name: "Team", foreign_key: "current_team_id", optional: true
    has_many :lineup_substitute_options, foreign_key: "substitute_player_id", dependent: :destroy

end
