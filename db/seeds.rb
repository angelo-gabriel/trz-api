# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
puts "Criando sobreviventes..."

survivor1 = Survivor.create!(
    name: "Alice Smith",
    age: 30,
    gender: "female",
    latitude: -5.0931,
    longitude: -42.8037
)
survivor2 = Survivor.create!(
    name: "Bob Johnson",
    age: 45,
    gender: "male",
    latitude: -5.0850,
    longitude: -42.8100
)

puts "Sobreviventes criados com sucesso!"

puts "Criando inventários..."
inventory1 = Inventory.create!(survivor: survivor1)
inventory2 = Inventory.create!(survivor: survivor2)
puts "Inventários criados com sucesso!"

puts "Criando itens..."

Item.create!([
  {
    name: "Água Purificada",
    price: 5,
    inventory: inventory1
  },
  {
    name: "Comida Enlatada",
    price: 10,
    inventory: inventory1
  },
  {
    name: "Kit de Primeiros Socorros",
    price: 20,
    inventory: inventory1
  },
  {
    name: "Munição (Caixa)",
    price: 15,
    inventory: inventory2
  },
  {
    name: "Lanterna",
    price: 8,
    inventory: inventory2
  }
])

puts "Itens criados com sucesso!"
