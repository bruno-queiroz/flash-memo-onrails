class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable
  validates :name, uniqueness: true
end
