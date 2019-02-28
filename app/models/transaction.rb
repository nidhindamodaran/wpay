class Transaction < ApplicationRecord
    belongs_to :bank_account, inverse_of: :transactions
    belongs_to :recipient, class_name: 'User'
    enum transaction_type: {transfered: 0, rewarded: 1}
end
