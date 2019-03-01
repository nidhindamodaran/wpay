class ScratchCard < ApplicationRecord
    belongs_to :user, inverse_of: :scratch_cards
    belongs_to :wpay_transaction, inverse_of: :scratch_cards

    scope :created_between, lambda {|start_date, end_date| 
        where("created_at >= ? AND created_at <= ?", start_date, end_date )
    }
end
