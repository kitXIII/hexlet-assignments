# frozen_string_literal: true

class Repository < ApplicationRecord
  validates :link, presence: true, uniqueness: true

  # BEGIN
  include AASM

  aasm do
    state :created, initial: true
    state :fetching, :fetched, :failed

    event :fetch do
      transitions to: :fetching
    end

    event :done do
      transitions from: :fetching, to: :fetched
    end

    event :fail do
      transitions to: :failed
    end
  end
  # END
end
