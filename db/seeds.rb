# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#seeding data for products
Product.create!(:name => "Samsung L50", :description => "A slim dual sim android 5.0 phone with amazing 18 mp camera." ,:price => "12000")
Product.create!(:name => "Motorola E6", :description => "A phone with a  octacore processor and an  inteligent power consumption system ." ,:price => "22000")

