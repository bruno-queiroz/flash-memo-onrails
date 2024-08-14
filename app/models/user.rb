class User < ApplicationRecord
  has_many :decks
  devise :database_authenticatable, :registerable, :rememberable
  validates :name, presence: true, uniqueness: true
end
