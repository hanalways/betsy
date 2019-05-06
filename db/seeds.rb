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
  ["Melinda Gates", "melindagates@gagoglezillionare.com"],
  ["Mark Zuckerberg", "markzuckerberg@robotalien.net"],
  ["Jeff Bezos", "jeffbezos@pureinsanity.com"],
]

merchant_list.each do |username, email|
  Merchant.create(
    username: username,
    email: email,
  )
end

category_failures = []
10.times do
  category = Category.new(name: Faker::Hacker.unique.adjective)
  success = category.save
  if !success
    category_failures << category
    puts "Failed to save category #{category.inspect}"
  else
    puts "Created category #{category.inspect}"
  end
end
puts "Added #{Category.count} category records"
puts "#{category_failures.length} categories failed to save"

product_failures = []

Product.create!(name: "0.1% diversity statistic",
                price: 100000,
                quantity: 150,
                description: "Add a whopping 01.% diversity statistic! looks great on presentations",
                image_url: "https://imgur.com/OMHSBtZ",
                merchant_id: rand(1..6),
                category_ids: (1..10).to_a.sample(3))

Product.create!(name: "0.2% diversity statistic",
                price: 150000,
                quantity: 150,
                description: "Add a whopping 02.% diversity statistic! looks great on presentations",
                image_url: "https://imgur.com/nS07PzS",
                merchant_id: rand(1..6),
                category_ids: (1..10).to_a.sample(3))

Product.create!(name: "0.3% diversity statistic",
                price: 250000,
                quantity: 150,
                description: "the deluxe and highly coveted 0.3% diversity statistic!",
                image_url: "https://imgur.com/3ZOqS2n",
                merchant_id: rand(1..6),
                category_ids: (1..10).to_a.sample(3))

Product.create!(name: "Code Cloud Pillow",
                price: 500,
                quantity: 150,
                description: "Enjoy sweet dreams on the cloud",
                image_url: "https://imgur.com/OFkih6c",
                merchant_id: rand(1..6),
                category_ids: (1..10).to_a.sample(3))

25.times do
  product = Product.new(
    name: "#{Faker::Games::ElderScrolls.race} #{Faker::Games::ElderScrolls.creature}",
    price: rand(10000).to_f / 100,
    quantity: 150,
    description: Faker::Hacker.say_something_smart,
    image_url: "https://placekitten.com/200/140",
    merchant_id: rand(1..6),
    category_ids: (1..10).to_a.sample(3),

  )
  success = product.save
  if !success
    product_failures << product
    puts "Failed to save product #{product.inspect}"
  else
    puts "Created product #{product.inspect}"
  end
end
puts "Added #{Product.count} product records"
puts "#{product_failures.length} products failed to save"
Order.create!(status: "shipped",
              email: "a@aol.com",
              address1: "123 Main St",
              city: "Providence",
              state: "RI",
              zip: 12345,
              last_four_cc: 1234,
              expiration: "12/12")

Order.create!(status: "pending",
              email: "b@aol.com",
              address1: "456 Spring St",
              city: "Treetown",
              state: "PA",
              zip: 34556,
              last_four_cc: 4567,
              expiration: "12/23")

Order.create!(status: "shipped",
              email: "r@gmail.com",
              address1: "56 Euclid Ave",
              city: "Santa Barbara",
              state: "CA",
              zip: 93110,
              last_four_cc: 4890,
              expiration: "04/21")

OrderProduct.create!(order_id: 1,
                     product_id: 3,
                     quantity: 5)

OrderProduct.create!(order_id: 2,
                     product_id: 12,
                     quantity: 1)

OrderProduct.create!(order_id: 2,
                     product_id: 20,
                     quantity: 3)

OrderProduct.create!(order_id: 3,
                     product_id: 5,
                     quantity: 12)

OrderProduct.create!(order_id: 1,
                     product_id: 13,
                     quantity: 4)

25.times do
  category = Category.new(
    name: "#{Faker::Company.buzzword}",

  )
  success = category.save
  if !success
    category_failures << category
    puts "Failed to save category #{category.inspect}"
  else
    puts "Created category #{category.inspect}"
  end

  puts "Added #{Category.count} category records"
  puts "#{category_failures.length} categories failed to save"
end
