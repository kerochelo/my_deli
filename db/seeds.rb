# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env == 'development'
  (1..50).each do |i|
    Article.create(name: "user#{i}", title: "title#{i}", url: "url#{i}", body: "body#{i}")
  end

  Tag.create([
    {name: "和食"},
    {name: "中華"},
    {name: "フレンチ"},
    {name: "イタリアン"},
    {name: "B級"},
    {name: "高級"}
  ])
end