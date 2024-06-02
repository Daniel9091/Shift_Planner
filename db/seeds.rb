# Limpia la base de datos
Membership.destroy_all
SectionGroup.destroy_all
Itinerary.destroy_all
Place.destroy_all
User.destroy_all

# Crear usuarios
users = []
5.times do |i|
  users << User.create(
    name: "User #{i+1}",
    email: "user#{i+1}@example.com",
    password_digest: BCrypt::Password.create("123456"),
    phone: "123-456-789#{i}",
    description: "Description for user #{i+1}",
    data_name: "nombre#{i}",
    data_rut: "11.111.111-#{i}",
    n_account: "ncuenta#{i}",
    account_type: "tipocuenta#{i}",
    banc: "banco#{i}",
    data_email: "email#{i}",
    driver_review: 1,
    passenger_review: 1
  )
end

# Crear lugares
uandes = Place.create(name: "Uandes")

additional_places = ["Copec", "Mall", "Plaza", "Supermercado", "Parque"]

additional_places.each do |place_name|
  Place.create(name: place_name)
end

# Crear itinerarios
10.times do |i|
  if i.even?
    starting_place = uandes
    ending_place = (Place.where.not(id: uandes.id)).sample
  else
    starting_place = (Place.where.not(id: uandes.id)).sample
    ending_place = uandes
  end

  Itinerary.create(
    status: ["Piloto", "Pasajero"].sample,
    day: ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"].sample,
    h_start: "07:00",
    h_end: "08:30",
    is_active: [true, false].sample,
    user: users.sample,
    starting_place: starting_place,
    ending_place: ending_place
  )
end


