class Order < ApplicationRecord
  # -------------
  # アソシエーション
  # -------------
  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details

  # -------------
  # バリデーション
  # -------------
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :shipping_cost, presence: true
  validates :total_payment, presence: true
  validates :payment_method, presence: true

  # (必須ではない)以下のように、郵便番号のカラムには7桁の数字しか入らないようにバリデーションを設定できる
  # format: { with: /\A\d{7}\z/ } は「7桁の数字」を意味する
  validates :postal_code, format: { with: /\A\d{7}\z/ }
  # validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ } とすると「3桁の数字-4桁の数字」を意味する
  # validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }のようにまとめて書くこともできる

  # (必須ではない)以下のように、金額のカラムには0以上の数値しか入らないようにバリデーションを設定できる
  # numericality: { greater_than_or_equal_to: 0 } は「0以上の数値」を意味する
  validates :shipping_cost, numericality: { greater_than_or_equal_to: 0 }
  validates :total_payment, numericality: { greater_than_or_equal_to: 0 }
  # validates :total_payment, presence: true, numericality: { greater_than_or_equal_to: 0 }のようにまとめて書くこともできる

  # enumを利用して支払方法を定義する
  enum payment_method: { credit_card: 0, transfer: 1 }

  # -------------
  # メソッド
  # -------------

  # 定義なし
end
