class Genre < ApplicationRecord
  # ジャンル機能

  # -------------
  # アソシエーション
  # -------------
  has_many :items, dependent: :destroy

  # -------------
  # バリデーション
  # -------------
  validates :name, presence: true
end
