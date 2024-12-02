
class TeamStat < ApplicationRecord
    belongs_to :team
    belongs_to :league
    belongs_to :user
  
    validates :matches_played, :wins, :draws, :losses, :goals_for, :goals_against, presence: true
    # Add more attributes based on your specific team statistics requirements
  end
  