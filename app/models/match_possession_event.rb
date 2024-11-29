class MatchPossessionEvent < ApplicationRecord
  belongs_to :match
  belongs_to :team

  # Method to calculate total possessions for a specific team in a match
  def self.total_possessions(team_id, match_id)
    where(team_id: team_id, match_id: match_id).sum()
  end
end
