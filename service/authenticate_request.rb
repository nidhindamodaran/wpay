class AuthenticateRequest
    prepend SimpleCommand

    def initialize(headers = {})
        @headers = headers
    end

    def call
        @user ||= User.find decoded_auth_token[:user_id] if decoded_auth_token.present?
        @user || errors.add(:token, 'Invalid Token') && nil
    end

    private

    attr_reader :headers

    def decoded_auth_token
        @decoded_auth_token ||= JsonWebToken.decode(auth_header)
    end

    def auth_header
        if headers['Authorization'].present?
            return headers['Authorization'].split(' ').last
        else
            errors.add(:token, 'Missing Token')
        end
        nil
    end
end