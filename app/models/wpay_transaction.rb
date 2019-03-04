class WpayTransaction < ApplicationRecord
    belongs_to :bank_account, inverse_of: :wpay_transactions, counter_cache: true
    belongs_to :recipient, class_name: 'User', optional: true

    has_many :scratch_cards, inverse_of: :wpay_transaction

    enum transaction_type: {transfered: 0, rewarded: 1}
end
