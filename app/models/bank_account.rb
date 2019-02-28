class BankAccount < ApplicationRecord
    belongs_to :user, inverse_of: :bank_accounts
    has_many :transactions, inverse_of: :bank_account
    validates :ifsc, uniqueness: {scope: :user_id}

    def self.primary_account_of(user: )
        user.bank_accounts.where(is_primary: true).first
    end
end
