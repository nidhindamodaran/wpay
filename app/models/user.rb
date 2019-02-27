class User < ApplicationRecord
    has_many :bank_accounts, inverse_of: :user
    has_secure_password
end
