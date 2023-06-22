class Item < ApplicationRecord
  # -------------
  # アソシエーション
  # -------------
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  has_one_attached :image

  # -------------
  # バリデーション
  # -------------
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  # (必須ではない)priceは、負の数にならないように0以上の制約をかけることができる
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  # presenceとまとめて、以下のように書くこともできる
  # validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # (必須ではない)以下のように、カスタムバリデーションを定義することもできる
  # ここでは、アップロードされた画像の形式を確認し、JPEGまたはPNG形式でなければエラーを返している
  validate :image_type

  def image_type
    if !image.blob
      errors.add(:image, 'をアップロードしてください')
    elsif !image.blob.content_type.in?(%('image/jpeg image/png'))
      errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
    end
  end

  # -------------
  # メソッド
  # -------------
  # 画像を取得するメソッド
  def get_image(*size)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      image.attach(io: File.open(file_path), filename: 'no-image.png', content_type: 'image/png')
    end
    if !size.empty?
      image.variant(resize: size)
    else
      image
    end
  end

  # 税込価格を取得するメソッド
  def with_tax_price
    (price * 1.1).ceil
    # ceilは切り上げ、floorが切り捨て、roundが四捨五入
  end

end
