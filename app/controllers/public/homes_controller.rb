class Public::HomesController < ApplicationController
  # このコントローラーはログインしていなくてもアクセスできるようにする
  def top
    # 新規商品を4つ表示
    # order(created_at: :desc)で作成日時の降順に並べ替え
    # limit(4)で上から4つまで取得
    @recent_items = Item.order(created_at: :desc).limit(4)
  end

  def about
  end
end
