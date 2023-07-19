class OrderDetail < ApplicationRecord
  # -------------
  # アソシエーション
  # -------------
  belongs_to :order
  belongs_to :item

  # -------------
  # バリデーション
  # -------------
  validates :price, presence: true
  validates :amount, presence: true

  # (必須ではない)numericality: { greater_than_or_equal_to: 0 }でpriceカラムが0以上の数値であるかを検証
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  # (必須ではない)numericality: { greater_than_or_equal_to: 1 }でamountカラムが1以上の数値であるかを検証
  validates :amount, numericality: { greater_than_or_equal_to: 1 }
  # ↑どちらも、Orderモデルで記載したように、presenceとnumericalityをまとめて記述することもできる

  # scopeを利用すると、同じorder_idの中でitem_idが重複しないようにバリデーションを設定できる
  validates :item_id, uniqueness: { scope: :order_id }

  # 製作ステータス
  # enumを利用して製作ステータスを定義する
  enum making_status: { impossible: 0, waiting: 1, in_production: 2, complete: 3 }

  # -------------
  # メソッド
  # -------------
  # 税込価格 * 数量を計算するメソッド
  def subtotal
    price * amount
  end

end
