class Genre < ApplicationRecord
  # <チャレンジ機能実装: ジャンル機能>

  # -------------
  # アソシエーション
  # -------------
  has_many :items, dependent: :destroy

  # -------------
  # バリデーション
  # -------------
  validates :name, presence: true
end
