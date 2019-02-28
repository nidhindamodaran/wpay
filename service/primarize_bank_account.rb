class PrimarizeBankAccount
    prepend SimpleCommand

    def initialize(account_number, current_user)
        @account_number = account_number
        @current_user = current_user
    end

    def call
        deactivated_account = deprimarize_account
        return unless deactivated_account

        account.update_attribute(:is_primary, true) || errors.add(:primary_account, "can't make account primary")
        account
    end

    private

    attr_reader :account_number, :current_user

    def deprimarize_account
        return primary_account.nil? || account.id == primary_account.id

        if primary_account.update_attribute(:is_primary, false)
            primary_account
        else
            errors.add(:primary_account, "can't deactivate existing account") && nil
        end
    end

    def account
        @account ||= BankAccount.find account_number
    end

    def primary_account
        @primary_account ||= BankAccount.primary_account_of(user: current_user)
    end
end