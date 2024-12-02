class Trophy < ApplicationRecord
    belongs_to :user
    belongs_to :team
    belongs_to :league
    has_many :trophy_players, dependent: :destroy
    has_many :players, through: :trophy_players
end
