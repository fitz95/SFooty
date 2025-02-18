class SeasonManager < ApplicationRecord
    belongs_to :season
    belongs_to :manager
    belongs_to :user
    belongs_to :team

    validates :role, presence: true
    validates :season_start_date, presence: true
    validates :status, presence: true
end
