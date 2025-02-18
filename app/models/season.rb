class Season < ApplicationRecord
    has_many :season_managers
    belongs_to :user
    has_many :teams, class_name: "Team", primary_key: "id", foreign_key: "id"

    serialize :teams, Array
end
