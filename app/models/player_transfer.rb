class PlayerTransfer < ApplicationRecord
    belongs_to :player
    belongs_to :user
    belongs_to :from_team, class_name: "Team", foreign_key: "from_team_id"
    belongs_to :to_team, class_name: "Team", foreign_key: "to_team_id"

    validates :transfer_date, presence: true
end
