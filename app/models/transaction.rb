class Transaction < ApplicationRecord
    belongs_to :bank_account
    belongs_to :recipient, class_name: 'User'
    enum transaction_type: [:transfered, :rewarded]
end
