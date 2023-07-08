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
  validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :postal_code, format: { with: /\A\d{7}\z/ }
  validates :telephone_number, format: { with: /\A\d{10,11}\z/ }
  # formatはpresenceとまとめて、以下のように書くこともできる
  # validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }

  # -------------
  # メソッド
  # -------------
  # 顧客のフルネームを返すメソッド
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

  # 顧客がカートに入れた商品の中に、引数で渡された商品が含まれているかを判定するメソッド
  # あればCartItemオブジェクトを返し、なければnilを返す
  def has_in_cart(item)
    cart_items.find_by(item_id: item.id)
  end
end
