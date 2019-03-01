class User < ApplicationRecord
    has_many :bank_accounts, inverse_of: :user, dependent: :destroy
    has_many :scratch_cards, inverse_of: :user
    validates :email, uniqueness: true
    has_secure_password
end
