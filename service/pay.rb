class Pay
    prepend SimpleCommand

    def initialize(amount:, recipient_id: , current_user: )
        @amount = amount
        @recipient_id = recipient_id
        @current_user = current_user
    end

    def call
        BankAccount.transaction do
            transfer
        end
    end

    private

    attr_reader :amount, :recipient_id, :current_user

    def transfer
        card = deduct_amount
        credit_to_benificiery
        if card.success?
            return card.result.as_json(root: true, only: [:id, :amount])
        end

    rescue ActiveRecord::RecordNotFound => exception
        errors.add(:recipient, 'not_found') && nil
    rescue PrimaryAccountError => e
        errors.add(:primary_account, e.message) && nil
    ensure
        raise ActiveRecord::Rollback if errors.present?
    end

    def deduct_amount
        raise PrimaryAccountError, 'no_account_configured' unless primary_account
        raise PrimaryAccountError, 'no_balance' unless has_sufficient_balance?

        transaction = primary_account.wpay_transactions.create(
            amount: amount,
            recipient: recipient,
            transaction_type: :transfered
        )
        card = GenerateScratchCard.call(transaction: transaction, current_user: current_user)
        primary_account.decrement!(:balance, amount)
    
        return card
    end

    def credit_to_benificiery
        raise PrimaryAccountError, 'recipient not added account' unless benificiary_account

        benificiary_account.increment!(:balance, amount)
    end

    def recipient
        @recipient ||= User.find recipient_id
    end

    def primary_account
        @primary_account ||= BankAccount.primary_account_of(user: current_user)
    end

    def has_sufficient_balance?
        primary_account.present? && (amount <= primary_account.balance)
    end

    def benificiary_account
        @benificiary_account ||= BankAccount.primary_account_of(user: recipient)
    end
end