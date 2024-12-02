class LineupPosition < ApplicationRecord
    validates :position_name, presence: true
    validates :position_order, presence: true
    belongs_to :formation
    has_many :lineup_players
    has_many :players, through: :lineup_players
    has_many :match_lineups, through: :lineup_players
    belongs_to :user
end
