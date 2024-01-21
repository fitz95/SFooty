class PlayerTeamHistory < ApplicationRecord
  belongs_to :player
  belongs_to :team
  belongs_to :user

  validates :player_id, presence: true
  validates :start_year, presence: true
end
