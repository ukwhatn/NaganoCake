class CartItem < ApplicationRecord
  # -------------
  # アソシエーション
  # -------------
  belongs_to :customer
  belongs_to :item

  # -------------
  # バリデーション
  # -------------
  # presence: trueでamountカラムが空欄でないかを検証
  validates :amount, presence: true
  # (必須ではない)numericality: trueでamountカラムが数値であるかを検証
  validates :amount, numericality: true
  # 上記はまとめて validates :amount, presence: true, numericality: true と書くこともできる

  # (必須ではない) item_idカラムがcustomer_idと組み合わせて一意であるかを検証
  # 受講生の実装の中ではコントローラ内で制御を行っている事が多いが、
  # バリデーションを用いると制御ミスによる重複登録を防ぐことができる
  validates :item_id, uniqueness: { scope: :customer_id }

  # -------------
  # メソッド
  # -------------
  # 税込価格 * 数量を計算するメソッド
  def subtotal
    item.with_tax_price * amount
  end
end
