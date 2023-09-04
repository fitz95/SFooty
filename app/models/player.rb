class Player < ApplicationRecord
    belongs_to :user
    belongs_to :current_team, class_name: "Team", foreign_key: "current_team_id", optional: true
end
