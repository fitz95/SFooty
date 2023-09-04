class PlayerTeamHistory < ApplicationRecord
    belongs_to :player
    belongs_to :team
    belongs_to :user
end
