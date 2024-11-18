class MatchGoal < ApplicationRecord
  belongs_to :match
  belongs_to :user
  belongs_to :player
  be

  validates :match_id, presence: true

end
