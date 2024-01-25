# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  completed   :boolean
#  creator     :string
#  description :text
#  name        :string
#  performer   :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  validates :name, :creator, presence: true

  attribute :status, :string, default: -> { 'New' }
  attribute :completed, :boolean, default: -> { false }
end
