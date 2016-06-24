class Borrower < ActiveRecord::Base
  has_secure_password
  has_many :transactions
  has_many :lenders, through: :transactions
	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :first_name, :last_name, :email, :amount_needed, :reason, :description, presence: true
	validates :email, uniqueness: {case_sensitive: false}, format: {:with => email_regex}
end
