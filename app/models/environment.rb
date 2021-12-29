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

class Environment < ApplicationRecord
  belongs_to :configuration

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
