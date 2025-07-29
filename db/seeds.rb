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
    gender: "female",
    latitude: -5.0931,
    longitude: -42.8037
)
bob = Survivor.create!(
    name: "Bob Johnson",
    age: 45,
    gender: "male",
    latitude: -5.0850,
    longitude: -42.8100
)

alice_inventory = Inventory.create!(survivor: alice) do
  puts " Criado inventário para Alice"
end

bob_inventory = Inventory.create!(survivor: bob) do
  puts " Criado inventário para Bob"
end

puts "Sobreviventes e inventários criados com sucesso!"

puts "Criando itens e atribuindo aos inventários..."

Item.create!([
  {
    name: "Água Purificada",
    price: 5,
    inventory: alice_inventory
  },
  {
    name: "Comida Enlatada",
    price: 10,
    inventory: alice_inventory
  },
  {
    name: "Kit de Primeiros Socorros",
    price: 20,
    inventory: alice_inventory
  },
  {
    name: "Munição (Caixa)",
    price: 15,
    inventory: bob_inventory
  },
  {
    name: "Lanterna",
    price: 8,
    inventory: bob_inventory
  }
])

puts "Itens criados com sucesso!"
puts "Seeds concluídas!"
