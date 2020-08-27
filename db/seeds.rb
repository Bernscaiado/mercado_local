require "faker"

Cart.delete_all
Product.delete_all
User.delete_all

user1 = User.create!(first_name: 'teste' ,last_name: 'teste', username: 'teste', email: 'teste@teste.com', password: 123123, role: true)
user2 = User.create!(first_name: 'teste1' ,last_name: 'teste1', username: 'teste1', email: 'teste1@teste.com', password: 123123, role: true)
user3 = User.create!(first_name: 'teste2' ,last_name: 'teste2', username: 'teste2', email: 'teste2@teste.com', password: 123123, role: true)

=begin
Category.create!(name: Queijos)
Category.create!(name: Cachaças)
Category.create!(name: Vinhos)
Category.create!(name: Cafés)
Category.create!(name: Chás)
Category.create!(name: Biscoitos)
Category.create!(name: Pães)
Category.create!(name: Bolos)
Category.create!(name: Geleias)
Category.create!(name: Antepastos)
=end

3.times do
 Product.create!(name: Faker::Dessert.variety, category: 'Sobremesa', price: rand(1..10).to_f, user: user1)
end

3.times do
  Product.create!(name: Faker::Food.fruits, category: 'Frutas', price: rand(1..10).to_f, user: user3)
end

3.times do
  Product.create!(name: Faker::Food.ingredient, category: 'Variados', price: rand(1..10).to_f, user: user2)
end

