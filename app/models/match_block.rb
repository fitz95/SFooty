class MatchBlock < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :team
  belongs_to :user
  belongs_to :opponent
end
