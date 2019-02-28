class GenerateScratchCard
    prepend SimpleCommand

    def initialize(transaction: , primary_account: )
        @transaction = transaction
        @primary_account = primary_account
    end

    def call
    end

    private

    attr_reader :transaction, :primary_account


end