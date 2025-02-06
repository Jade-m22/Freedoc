class AddCityToAppointments < ActiveRecord::Migration[8.0]
  def change
    add_reference :appointments, :city, null: false, foreign_key: true
  end
end
