class Team < ApplicationRecord
  belongs_to :league
  belongs_to :user
  has_many :players
  belongs_to :league
  has_many :match_events, dependent: :nullify
end
