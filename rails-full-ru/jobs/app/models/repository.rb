# frozen_string_literal: true

class Repository < ApplicationRecord
  validates :link, presence: true, uniqueness: true

  # BEGIN
  include AASM

  aasm whiny_transitions: false do
    state :created, initial: true
    state :fetching, :fetched, :failed

    event :fetch do
      transitions from: %i[created failed fetching fetched], to: :fetching
    end

    event :done do
      transitions from: :fetching, to: :fetched
    end

    event :fail do
      transitions from: %i[created failed fetched], to: :failed
    end
  end
  # END
end
