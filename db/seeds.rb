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

puts "Limpando dados existentes..."
Item.destroy_all
Inventory.destroy_all
Survivor.destroy_all
puts "Dados limpos."

puts "Criando sobreviventes e seus inventários..."

alice = Survivor.create!(
    name: "Alice Smith",
    age: 30,
    gender: :female,
    latitude: -5.0931,
    longitude: -42.8037
)
bob = Survivor.create!(
    name: "Bob Johnson",
    age: 45,
    gender: :male,
    latitude: -5.0850,
    longitude: -42.8100
)

alice_inventory = Inventory.create!(survivor: alice)
bob_inventory = Inventory.create!(survivor: bob)

puts "Sobreviventes e inventários criados com sucesso!"

puts "Criando itens e atribuindo aos inventários..."

# Itens da Alice
Item.create!(inventory: alice_inventory, name: "Fiji Water") do |item|
  item.price = 14
  item.quantity = 10
end

Item.create!(inventory: alice_inventory, name: "Campbell Soup") do |item|
  item.price = 12
  item.quantity = 5
end

# Itens do Bob
Item.create!(inventory: bob_inventory, name: "First Aid Pouch") do |item|
  item.price = 10
  item.quantity = 8
end

Item.create!(inventory: bob_inventory, name: "AK47") do |item|
  item.price = 8
  item.quantity = 3
end

puts "Itens criados com sucesso!"
puts "Seeds concluídas!"
