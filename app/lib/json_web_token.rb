# app/lib/json_web_token.rb
class JsonWebToken
  SECRET_KEY = Rails.application.secret_key_base  # This automatically loads from credentials

  # Encode payload with expiration
  def self.encode(payload, exp = 24.hours.from_now)
    binding.pry
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  # Decode token
  def self.decode(token)
    begin
      decoded = JWT.decode(token, SECRET_KEY)[0]  # Decoding returns an array, we use the first element
      HashWithIndifferentAccess.new(decoded)  # Ensure it's a hash
    rescue JWT::DecodeError, JWT::ExpiredSignature => e
      Rails.logger.error "JWT Decode Error: #{e.message}"
      nil  # Return nil if the token is invalid or expired
    end
  end
end
