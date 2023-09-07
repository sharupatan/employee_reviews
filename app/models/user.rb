class User < ApplicationRecord
  validates :name, :role, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true

	has_many :reviews
end
