class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true

  belongs_to :user

end
