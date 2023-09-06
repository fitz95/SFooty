class PlayerStat < ApplicationRecord
    belongs_to :player
    belongs_to :match
    belongs_to :user

    validates :player_id, presence: true
    validates :match_id, presence: true
    validates :goals_scored, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
