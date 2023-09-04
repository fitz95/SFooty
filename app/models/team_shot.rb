class TeamShot < ApplicationRecord
    belongs_to :team
    belongs_to :match
    belongs_to :user
end
