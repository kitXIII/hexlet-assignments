class PostComment < ApplicationRecord
  belongs_to :post

  validates :body, presence: true, length: { maximum: 500 }
end
