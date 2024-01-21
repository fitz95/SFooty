class TeamShot < ApplicationRecord
  belongs_to :team
  belongs_to :match
  belongs_to :user

  # Example: A scope to find team shots on target in a specific match
  scope :shots_on_target_in_match, ->(match_id) { where(match_id:).sum(:shots_on_target) }
end
