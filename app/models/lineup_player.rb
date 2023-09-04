class LineupPlayer < ApplicationRecord
    belongs_to :lineup_position
    belongs_to :player
    belongs_to :user
    belongs_to :match_lineup
end

