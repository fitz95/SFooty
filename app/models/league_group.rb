class LeagueGroup < ApplicationRecord
    belongs_to :league
    belongs_to :user
    has_many :teams
    has_many :game_weeks
    has_many :matches
end
