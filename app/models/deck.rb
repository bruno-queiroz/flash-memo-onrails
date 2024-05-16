class Deck < ApplicationRecord
    has_many :cards
    belongs_to :user

    validates :title, presence: true, uniqueness: { scope: :user_id }
end
