class MatchOfficial < ApplicationRecord
    belongs_to :user
    has_many :match_official_for_matches, dependent: :destroy,foreign_key: 'match_official_id', inverse_of: :match_official, counter_cache: :match_official_for_matches_count
    has_many :matches, through: :match_official_for_matches
end
