class User < ApplicationRecord
  has_many :decks
  devise :database_authenticatable, :registerable, :rememberable
  validates :name, uniqueness: true
end
