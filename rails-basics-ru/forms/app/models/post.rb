class Post < ApplicationRecord
  validates :title, :summary, presence: true

  attribute :published, :boolean, default: -> { false }
end
