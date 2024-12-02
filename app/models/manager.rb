class Manager < ApplicationRecord
    validates :name, presence: true

    has_many :season_managers
    has_many :teams
end
