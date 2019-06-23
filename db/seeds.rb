# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(first_name: 'Fist', last_name: 'Test', identification: '1234567890', address: 'Street 85 # 45', email: 'first@test.com', password:'123abc')
User.create(first_name: 'Second', last_name: 'Test', identification: '9876543210', address: 'Street 85 # 45', email: 'second@test.com', password:'456abc')
station_1 = Station.create(address: 'Street 85 # 45')
station_2 = Station.create(address: 'Street 45 # 85')
Bike.create(serial_number: '123abc', station_id: station_1.id )
Bike.create(serial_number: '456def', station_id: station_1.id )
Bike.create(serial_number: '789ghi', station_id: station_2.id )
