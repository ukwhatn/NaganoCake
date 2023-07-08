# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者アカウント作成
if Admin.count == 0
  Admin.create!(
    email: 'admin@dwc.com',
    password: 'admin123'
  )
end

# Item作成
items = {
  'butter_cookie' => {
    name: 'バタークッキー',
    description: 'バターの風味が香るクッキーです。',
    price: 300,
  },
  'chocolate_cake' => {
    name: 'チョコレートケーキ',
    description: 'チョコレートの風味が香るケーキです。',
    price: 400,
  },
  'chocolate_cookie' => {
    name: 'チョコレートクッキー',
    description: 'チョコレートの風味が香るクッキーです。',
    price: 300,
  },
  'donuts' => {
    name: 'ドーナツ',
    description: '甘いドーナツです。',
    price: 200,
  },
  'dorayaki' => {
    name: 'どら焼き',
    description: '甘いどら焼きです。',
    price: 250,
  },
  'ekrea' => {
    name: 'エクレア',
    description: '甘いエクレアです。',
    price: 300,
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
  'strawberry_cake' => {
    name: '苺のショートケーキ',
    description: '苺の風味が香るケーキです。',
    price: 400,
  },
  'taiyaki' => {
    name: 'たい焼き',
    description: '甘いたい焼きです。',
    price: 200,
  },
  'waffle' => {
    name: 'ワッフル',
    description: '甘いワッフルです。',
    price: 200,
  }
}

items.each do |key, value|
  if Item.find_by(name: value[:name]).nil?
    item = Item.create!(
      name: value[:name],
      description: value[:description],
      price: value[:price]
    )
    item.image.attach(io: File.open(Rails.root.join("db/fixtures/#{key}.jpg")), filename: "#{key}.jpg")
  end
end