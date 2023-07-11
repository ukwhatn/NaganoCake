class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # -------------
  # アソシエーション
  # -------------
  # ordersにはdependent: :destroyを設定していないので
  # 顧客が削除されても、その顧客が注文した情報は残る
  has_many :orders
  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy

  # -------------
  # バリデーション
  # -------------
  # 必要なカラムには一意性制約(uniqueness: true)を設定する
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true, uniqueness: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

  # (必須ではない)以下のように、カナ指定や郵便番号、電話番号にはformat制約をかけるのが一般的
  # format: { with: /\A[ァ-ヶー－]+\z/ } は「カタカナ」を意味する
  # format: { with: /\A\d{7}\z/ } は「7桁の数字」を意味する (ハイフンありの場合は /\A\d{3}-\d{4}\z/ とする)
  # format: { with: /\A\d{10,11}\z/ } は「10桁または11桁の数字」を意味する
  # allow_blank: true で「入力値があった場合のみ」実行されるようにしている（入力値の有無はpresence: trueでチェックしている）
  validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "はカタカナで入力してください", allow_blank: true }
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "はカタカナで入力してください", allow_blank: true }
  validates :postal_code, format: { with: /\A\d{7}\z/, message: "はハイフンなし7桁の数字で入力してください", allow_blank: true }
  validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: "はハイフンなし10桁または11桁の数字で入力してください", allow_blank: true }

  # -------------
  # メソッド
  # -------------
  # 顧客のフルネームや住所を返すメソッド
  # viewでいちいち書くよりもこちらの方が実装として適している
  def full_name
    last_name + " " + first_name
  end

  def full_name_kana
    last_name_kana + " " + first_name_kana
  end

  def full_address
    "〒" + postal_code + " " + address
  end
end
