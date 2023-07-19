class Address < ApplicationRecord
  # 配送先登録

  # -------------
  # アソシエーション
  # -------------
  belongs_to :customer

  # -------------
  # バリデーション
  # -------------
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

  # (必須ではない)Customerと同様にformat制約をかける
  validates :postal_code, format: { with: /\A\d{7}\z/, message: "はハイフンなし7桁の数字で入力してください", allow_blank: true }

  # -------------
  # メソッド
  # -------------
  # 住所を結合した文字列を返す
  def full_address
    "〒" + postal_code + " " + address + " " + name
  end
end
