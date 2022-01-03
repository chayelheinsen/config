# == Schema Information
#
# Table name: api_keys
#
#  id           :uuid             not null, primary key
#  name         :string           not null
#  token_digest :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_api_keys_on_token_digest  (token_digest) UNIQUE
#

class APIKey < ApplicationRecord
  validates :name, presence: true

  before_create :generate_token_hmac_digest
 
  # Virtual attribute for raw token value, allowing us to respond with the
  # API key"s non-hashed token value. but only directly after creation.
  attr_accessor :token
 
  def self.authenticate_by_token!(token)
    digest = OpenSSL::HMAC.hexdigest("SHA256", secret_key, token)

    find_by!(token_digest: digest)
  end
 
  def self.authenticate_by_token(token)
    authenticate_by_token!(token)
  rescue ActiveRecord::RecordNotFound
    nil
  end
 
  # Add virtual token attribute to serializable attributes, and exclude
  # the token"s HMAC digest
  def serializable_hash(options = nil)
    h = super options.merge(except: "token_digest")
    h.merge!({ "token": token }) if token.present?
    h
  end
 
  private
 
  def generate_token_hmac_digest
    self.token = SecureRandom.hex
    digest = OpenSSL::HMAC.hexdigest("SHA256", APIKey.secret_key, self.token)

    self.token_digest = digest
  end 

  def self.secret_key
    Rails.application.secrets.secret_key_base
  end
end
