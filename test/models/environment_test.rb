# == Schema Information
#
# Table name: environments
#
#  id               :uuid             not null, primary key
#  name             :citext           not null
#  configuration_id :uuid             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_environments_on_configuration_id  (configuration_id)
#

require "test_helper"

class EnvironmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
