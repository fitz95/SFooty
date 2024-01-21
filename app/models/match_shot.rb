class MatchShot < ApplicationRecord
  belongs_to :match
  belongs_to :user
  belongs_to :team
  belongs_to :player
end
