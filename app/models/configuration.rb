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

class Configuration < ApplicationRecord
  has_one :environment

  validates :content, presence: true

  delegate :name, to: :environment, allow_nil: true
end
