class Match < ApplicationRecord
    belongs_to :user
    belongs_to :stadium
    belongs_to :referee
    belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
    belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'
    belongs_to :league
    belongs_to :game_week
    has_many :match_events, dependent: :destroy
    has_many :match_goals, dependent: :destroy

end
