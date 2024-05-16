class Card < ApplicationRecord
    belongs_to :deck

    validates :front, presence: true, uniqueness: { scope: :deck_id }
    validates :back, presence: true
    validates :review_at, presence: false
    validates :ease_factor, presence: true
    validates :interval, presence: true
    validates :repetitions, presence: true
end
