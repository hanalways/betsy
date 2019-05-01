# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

merchant_list = [
  ["Ada Lovelace", "adalovelace@codinggod.com"],
  ["Steve Jobs", "stevejobs@dead.com"],
  ["Bill Gates", "billgates@gagoglezillionare.com"],
  ["Melinda Gates", "melindagates@gagogle"],
  ["Mark Zuckerberg", "markzuckerberg@robotalien.net"],
  ["Jeff Bezos", "jeffbezos@pureinsanity.com"]
]

merchant_list.each do |username, email|
  Merchant.create(
    username: username,
    email: email,
  )
end
product_failures = []

25.times do
  product = Product.new(
    name: "#{Faker::Games::ElderScrolls.race} #{Faker::Games::ElderScrolls.creature}",
    price: rand(10000).to_f / 100,
    quantity: rand(10),
    image_url: "https://placekitten.com/200/140",
  )
  success = product.save
  if !success
    product_failures << product
    puts "Failed to save product #{product.inspect}"
  else
    puts "Created product #{product.inspect}"
  end

  puts "Added #{Product.count} product records"
  puts "#{product_failures.length} products failed to save"
end
