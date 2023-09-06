class LineupPosition < ApplicationRecord
    belongs_to :formation
    has_many :lineup_players
    has_many :players, through: :lineup_players
    belongs_to :user
end
