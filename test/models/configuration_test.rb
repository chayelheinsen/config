# == Schema Information
#
# Table name: configurations
#
#  id         :uuid             not null, primary key
#  content    :jsonb            default("\"{}\""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_configurations_on_content  (content)
#

require "test_helper"

class ConfigurationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
