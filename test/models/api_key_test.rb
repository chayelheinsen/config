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

require "test_helper"

class APIKeyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
