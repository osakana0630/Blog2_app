class Profile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  #has_many :articles
end
