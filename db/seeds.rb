# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
