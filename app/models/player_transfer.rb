class PlayerTransfer < ApplicationRecord
    belongs_to :player
    belongs_to :user
    belongs_to :from_club, class_name: "Club", foreign_key: "from_club_id"
    belongs_to :to_club, class_name: "Club", foreign_key: "to_club_id"
end
