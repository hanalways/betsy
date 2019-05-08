# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

diversity = Category.create(
  name: "Diversity",
)

rubber_ducky = Category.create!(
  name: "Rubber Ducky",
)

lifestyle = Category.create!(
  name: "Lifestyle",
)

networking = Category.create!(
  name: "Networking",
)

work = Category.create!(
  name: "Work",
)

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

Product.create!(name: "0.1% diversity statistic",
                price: 100000,
                quantity: 150,
                description: "Add a whopping 01.% diversity statistic! looks great on presentations",
                image_url: "https://i.imgur.com/OMHSBtZ.jpg",
                merchant_id: rand(1..6),
                category_ids: diversity.id)

Product.create!(name: "0.2% diversity statistic",
                price: 150000,
                quantity: 150,
                description: "Add a whopping 02.% diversity statistic! looks great on presentations",
                image_url: "https://i.imgur.com/nS07PzS.jpg",
                merchant_id: rand(1..6),
                category_ids: diversity.id)

Product.create!(name: "0.3% diversity statistic",
                price: 250000,
                quantity: 150,
                description: "the deluxe and highly coveted 0.3% diversity statistic!",
                image_url: "https://i.imgur.com/3ZOqS2n.jpg",
                merchant_id: rand(1..6),
                category_ids: diversity.id)

Product.create!(name: "Code Cloud Pillow",
                price: 500,
                quantity: 150,
                description: "Enjoy sweet dreams on the cloud",
                image_url: "https://i.imgur.com/OFkih6c.jpg",
                merchant_id: rand(1..6),
                category_ids: lifestyle.id)

Product.create!(name: "Batman Rubber Duckie",
                price: 200,
                quantity: 150,
                description: "Have him talk you through your bugs! remember... The night is darkest just before the dawn.",
                image_url: "https://i.imgur.com/G6hGf3yt.jpg",
                merchant_id: rand(1..6),
                category_ids: rubber_ducky.id)

Product.create!(name: "Angry Manager Rubber Duckie",
                price: 200,
                quantity: 150,
                description: "Work through the bugs!",
                image_url: "https://i.imgur.com/NECimf9t.jpg",
                merchant_id: rand(1..6),
                category_ids: rubber_ducky.id)

Product.create!(name: "Hopeful Intern Rubber Duckie",
                price: 200,
                quantity: 150,
                description: "Explain to the intern how you fixed your bugs!",
                image_url: "https://i.imgur.com/TdogQiwt.jpg",
                merchant_id: rand(1..6),
                category_ids: rubber_ducky.id)

Product.create!(name: "Viking Rubber Duckie",
                price: 200,
                quantity: 150,
                description: "Conquer the bugs!",
                image_url: "https://i.imgur.com/pVJNSrlt.jpg",
                merchant_id: rand(1..6),
                category_ids: rubber_ducky.id)

Product.create!(name: "Innovative Startup Idea ",
                price: 2000000,
                quantity: 150,
                description: "Do you have what it takes to become one of the tech giants? you will with this idea!",
                image_url: "https://i.imgur.com/PJDrEhht.jpg",
                merchant_id: rand(1..6),
                category_ids: networking.id)

Product.create!(name: "Exclusive Invite To Lunch ",
                price: 15000,
                quantity: 150,
                description: "Ever wonder what lunch is served on the other side...buy a pass to eat and network at Microsoft, Amazon or google! ",
                image_url: "https://i.imgur.com/WqVwqgJt.png",
                merchant_id: rand(1..6),
                category_ids: networking.id)

Product.create!(name: "Exclusive Invite To Google Hackathon ",
                price: 100000,
                quantity: 150,
                description: "This could be you! Join a google hackathon ",
                image_url: "https://i.imgur.com/dFumwgtt.jpg",
                merchant_id: rand(1..6),
                category_ids: networking.id)

Product.create!(name: "Soylent ",
                price: 25,
                quantity: 150,
                description: "The only food/drink you will ever need",
                image_url: "https://i.imgur.com/9BQFeSDt.jpg",
                merchant_id: rand(1..6),
                category_ids: lifestyle.id)

Product.create!(name: "Soylent Cozy ",
                price: 50,
                quantity: 150,
                description: "Coosie...to be used with soylent only",
                image_url: "https://i.imgur.com/75OWCVCt.jpg",
                merchant_id: rand(1..6),
                category_ids: lifestyle.id)

Product.create!(name: "Dan Can ",
                price: 1500,
                quantity: 150,
                description: "Tired of wasting your breath? look no further than the dan can! comes with many options such as Hello!, Keep up the good work!, You have a strong start!, See my inline comments, I see you have met all the learning requirements",
                image_url: "https://i.imgur.com/qsBxp96t.jpg",
                merchant_id: rand(1..6),
                category_ids: work.id)

Product.create!(name: "Canned Interview Response ",
                price: 1000,
                quantity: 150,
                description: "Can't be bothered to comment on a potential employees whiteboard interview? Buy our canned responses!",
                image_url: "https://i.imgur.com/qsBxp96t.jpg",
                merchant_id: rand(1..6),
                category_ids: work.id)

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
                     product_id: 5,
                     quantity: 3)

OrderProduct.create!(order_id: 3,
                     product_id: 5,
                     quantity: 12)

OrderProduct.create!(order_id: 1,
                     product_id: 13,
                     quantity: 4)

Review.create!([
  { text: "this was just what our company needed", title: "wow cool so much diversity", rating: 3, product_id: 2 },
  { text: "Working at TechBro Inc. it is such a big relief to know that our company is the cutting edge of diversity with this product. Before, we were nervous about interacting with our diverse candidates in fear of what could happen (y'know, amirite?). But now, we can rely on our new diversity hire to bring up morale! They are such a good listener, and we can really tell that she is absorbing and fitting into our culture. Thanks HaCKSy!", title: "Diversity made easy!", rating: 3, product_id: 3 },
])
