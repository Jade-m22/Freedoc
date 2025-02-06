# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

paris = City.create(name: 'Paris')
lyon = City.create(name: 'Lyon')
marseille = City.create(name: 'Marseille')

specialties = ['Cardiologie', 'Dermatologie', 'Pédiatrie', 'Neurologie', 'Chirurgie']
specialty_objects = specialties.map { |specialty| Specialty.create(name: specialty) }

10.times do
  doctor = Doctor.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    specialty: specialties.sample,
    zip_code: Faker::Address.zip_code,
    city: [paris, lyon, marseille].sample
  )

  rand(1..3).times do
    DoctorSpecialty.create(doctor: doctor, specialty: specialty_objects.sample)
  end
end


20.times do
  Patient.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    city: [paris, lyon, marseille].sample
  )
end


Doctor.all.each do |doctor|
  5.times do
    patient = Patient.all.sample
    Appointment.create(
      date: Faker::Time.between_dates(from: Date.today, to: Date.today + 1, period: :morning), # Rendez-vous le matin
      doctor: doctor,
      patient: patient
    )
  end
end

puts "Tout fonctionne !"