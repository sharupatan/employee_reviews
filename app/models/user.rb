class User < ApplicationRecord
  validates :name, :role, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true

	has_many :reviews

	def admin?
		self.role == 'admin'
	end

	def super_admin?
		self.role == 'super_admin'
	end
end
