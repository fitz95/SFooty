class GameWeek < ApplicationRecord
    belongs_to :league
    belongs_to :user
    has_many :matches
end
