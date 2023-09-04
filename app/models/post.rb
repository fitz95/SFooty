class Post < ApplicationRecord
    belongs_to :user
    belongs_to :team
    belongs_to :league
    belongs_to :player
end