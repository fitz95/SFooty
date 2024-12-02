class MatchClearance < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :team
end
