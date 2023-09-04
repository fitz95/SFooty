class LineupPosition < ApplicationRecord
    belongs_to :formation
    belongs_to :user
end
