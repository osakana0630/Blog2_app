class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #ユーザーのデータを消したときに紐づいたprofileも消してくれる
  has_one :profile, dependent: :destroy
  has_many :articles, dependent: :destroy
  delegate :name, to: :profile, allow_nil: true

end
