# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者アカウント作成
admins = [
  {
    email: 'admin@dwc.com',
    password: 'admin123'
  }
]
admins.each do |admin|
  if Admin.find_by(email: admin[:email]).nil?
    Admin.create!(admin)
  end
end

# 顧客アカウント・アドレス作成
customers = {
  'taro' => %w[太郎 タロウ],
  'hanako' => %w[花子 ハナコ],
  'jiro' => %w[次郎 ジロウ],
  'saburo' => %w[三郎 サブロウ],
  'shiro' => %w[四郎 シロウ],
  'goro' => %w[五郎 ゴロウ],
  'rokuro' => %w[六郎 ロクロウ],
  'shichiro' => %w[七郎 シチロウ],
  'hachiro' => %w[八郎 ハチロウ],
  'kuro' => %w[九郎 クロウ],
  'juuro' => %w[十郎 ジュウロウ]
}

addresses = [
  {
    name: '別住所①',
    postal_code: '1234567',
    address: '東京都千代田区千代田1-1-1'
  },
  {
    name: '別住所②',
    postal_code: '1234567',
    address: '東京都千代田区千代田2-2-2'
  },
]

customers.each_with_index do |(key, value), i|
  customer = {
    email: "#{key}@dwc.com",
    password: "password",
    last_name: "めんたー",
    first_name: value[0],
    last_name_kana: "メンター",
    first_name_kana: value[1],
    postal_code: "12345#{format('%02d', i + 1)}",
    address: "東京都渋谷区渋谷#{i + 1}-#{i + 1}-#{i + 1}",
    telephone_number: "090123456#{format('%02d', i + 1)}"
  }
  if Customer.find_by(email: customer[:email]).nil?
    c = Customer.create!(customer)
    addresses.each do |address|
      c.addresses.create!(address)
    end
  end
end

# Item作成
items = {
  "ケーキ" => {
    'chocolate_cake' => {
      name: 'チョコレートケーキ',
      description: 'チョコレートの風味が香るケーキです。',
      price: 400,
    },
    'strawberry_cake' => {
      name: '苺のショートケーキ',
      description: '苺の風味が香るケーキです。',
      price: 400,
    },
  },
  "焼き菓子" => {
    'butter_cookie' => {
      name: 'バタークッキー',
      description: 'バターの風味が香るクッキーです。',
      price: 300,
    },
    'chocolate_cookie' => {
      name: 'チョコレートクッキー',
      description: 'チョコレートの風味が香るクッキーです。',
      price: 300,
    },
    'waffle' => {
      name: 'ワッフル',
      description: '甘いワッフルです。',
      price: 200,
    }
  },
  "和菓子" => {
    'dorayaki' => {
      name: 'どら焼き',
      description: '甘いどら焼きです。',
      price: 250,
    },
    'goma_daifuku' => {
      name: '胡麻大福',
      description: '胡麻の風味が香る大福です。',
      price: 200,
    },
    'imagawa_yaki' => {
      name: '今川焼き',
      description: '甘い今川焼きです。',
      price: 200,
    },
    'konpeitou' => {
      name: '金平糖',
      description: '甘い金平糖です。',
      price: 100,
    },
    'mitarashi' => {
      name: 'みたらし団子',
      description: '甘いみたらし団子です。',
      price: 200,
    },
    'monaka' => {
      name: '最中',
      description: '甘い最中です。',
      price: 200,
    },
    'sakura_mochi' => {
      name: '桜餅',
      description: '桜の風味が香る餅です。',
      price: 200,
    },
    'taiyaki' => {
      name: 'たい焼き',
      description: '甘いたい焼きです。',
      price: 200,
    },
  },
  "その他" => {
    'ekrea' => {
      name: 'エクレア',
      description: '甘いエクレアです。',
      price: 300,
    },
    'donuts' => {
      name: 'ドーナツ',
      description: '甘いドーナツです。',
      price: 200,
    },
  },
}

items.each do |genre_name, genre_items|
  genre = Genre.find_by(name: genre_name)
  if genre.nil?
    genre = Genre.create!(name: genre_name)
  end
  genre_items.each do |key, value|
    if Item.find_by(name: value[:name]).nil?
      item = genre.items.create!(value)
      item.image.attach(io: File.open(Rails.root.join("db/fixtures/#{key}.jpg")), filename: "#{key}.jpg")
    end
  end
end
