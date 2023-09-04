class MatchOfficialForMatch < ApplicationRecord
    belongs_to :match
    belongs_to :match_official
    belongs_to :user
end
