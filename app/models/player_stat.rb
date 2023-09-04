class PlayerStat < ApplicationRecord
    belongs_to :player
    belongs_to :match
    belongs_to :user
end
