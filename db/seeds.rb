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