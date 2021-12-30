class AuthToken
  class TokenError < StandardError; end
  class TokenValidationError < StandardError; end

    # Encodes a payload hash using JWT
    #
    # Valid Claims:
    # 'sub' (Subject) - Required - This should be the user_id
    # 'scope' (Scope) - Required - Where this token is valid
    #
    # 'exp' (Expiration Time) - Required
    #      This will be set to 1 day by default, but you can extend it if needed.
    # 'nbf' (Not Before Time) - This will be set to now by default, but you can extend it if needed.
    # 'aud' (Audience) - Required - The intended user - This will be defaulted for you
    #
    # Invalid Claims:
    # 'iss' (Issuer) - You should not pass this, as AuthToken will already set this and validate it when decoding.
    #                  If you pass this claim, decoding WILL FAIL.
    #
    # 'iat' (Issued At) - Don't pass this, AuthToken will handle this.
    #
    # Usage: AuthToken.encode(claims)
    def encode(payload)
      JWT.encode(
       default_payload.merge(payload),
        self.class.secret_key_base,
        self.class.algorithm,
      )
    end

    private 

    def default_payload
      { 
        exp: 1.day.from_now.to_i,
        iat: Time.now.to_i, 
        nbf: Time.now.to_i, 
        iss: self.class.issuer,
        aud: "Staff",
        scope: self.class.scope
      }
    end

  class << self
    # Decodes a token
    #
    # This can throw an exception if the token is not valid
    #
    # JWT::ExpiredSignature - If the exp claim is before now, the token has been expired
    # JWT::ImmatureSignature - If now is before the nbf claim, the token isn't valid yet; being used too early
    # JWT::InvalidIssuerError - If the iss claim is not what is expected
    # JWT::MissingRequiredClaim - If any of the required claims are missing
    def decode(token)
      HashWithIndifferentAccess.new(
        JWT.decode(
          token, 
          secret_key_base, 
          true, 
          decode_options
        ).first,
      )
    rescue JWT::DecodeError
    end

    def scope
      "general"
    end

    def issuer
      "StarLight Creations Inc - Hoshi"
    end

    # def validate!(decoded_token, sub)
    #   validate_scope!(decoded_token)
    #   validate_sub!(decoded_token, expected_sub)
    # end

    # def validate_scope!(decoded_token)
    #   if decoded_token.scope != scope
    #     raise(
    #       AuthToken::TokenValidationError,
    #       "Scope Mismatch - This token is not valid for this request",
    #     )
    #   end
    # end

    # def validate_sub!(decoded_token, expected_sub)
    #   if decoded_token.sub != expected_sub
    #     raise(
    #       AuthToken::TokenValidationError,
    #       "sub Mismatch - This token does not match the sub",
    #     )
    #   end
    # end

    def algorithm
      "HS256"
    end

    def decode_options
      {
        iss: issuer,
        verify_iss: true,
        verify_iat: true,
        required_claims: required_claims,
        algorithm: algorithm
      }
    end

    def required_claims
      %i[
        iat
        iss
        aud
        exp
        sub
        scope
      ]
    end

    def secret_key_base
      Rails.application.secrets.secret_key_base
    end
  end
end