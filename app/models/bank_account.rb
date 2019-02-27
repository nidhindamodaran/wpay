class BankAccount < ApplicationRecord
    belongs_to :user, inverse_of: :bank_accounts
end
