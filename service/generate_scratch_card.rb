class GenerateScratchCard
    prepend SimpleCommand

    def initialize(transaction: , current_user: )
        @transaction = transaction
        @current_user = current_user
    end

    def call
        return unless eligible?
        generate_scratch_card
    end

    private

    attr_reader :transaction, :current_user

    def generate_scratch_card
        card = current_user.scratch_cards.new(amount: generate_amount, wpay_transaction: transaction)
        card.save && card
    end

    def scratch_cards
        @cards ||= current_user.scratch_cards
    end
    
    def eligible?
        in_a_year = scratch_cards.created_between(1.year.ago, Time.now)
        return false if in_a_year.count >= 10
        in_a_month = scratch_cards.created_between(1.month.ago, Time.now)
        return false if in_a_month.count >= 4
        in_a_day = scratch_cards.created_between(1.day.ago, Time.now)
        return false if in_a_day.count >= 2

        return true
    end

    def generate_amount
        rand(500..5000)
    end

end