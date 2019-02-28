class User < ApplicationRecord
    has_many :bank_accounts, inverse_of: :user, dependent: :destroy
    validates :email, uniqueness: true
    has_secure_password
end
