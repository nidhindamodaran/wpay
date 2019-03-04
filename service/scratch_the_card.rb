class ScratchTheCard
    prepend SimpleCommand

    def initialize(scratch_card_id:, current_user: )
        @scratch_card_id = scratch_card_id
        @current_user = current_user
    end

    def call
        raise PrimaryAccountError, 'no primary account' unless primary_account
        return if scratch_card.seen
        
        if scratch_card.update_attribute(:seen, true)
            transaction = primary_account.wpay_transactions.create(
                amount: scratch_card.amount,
                transaction_type: :rewarded
            )
            primary_account.increment!(:balance, scratch_card.amount)
            return transaction
        end

        return errors.add(:scratch_card, "can't scratch") && nil

    rescue PrimaryAccountError => e
        return errors.add(:primary_account, e.message) && nil
    end

    private

    attr_reader :scratch_card_id, :current_user

    def scratch_card
        @scratch_card ||= ScratchCard.find(scratch_card_id)
    end

    def primary_account
        @primary_account ||= BankAccount.primary_account_of(user: current_user)
    end
end