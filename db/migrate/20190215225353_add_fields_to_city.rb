class AddFieldsToCity < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :latitude, :string
    add_column :cities, :longitud, :string
    add_column :cities, :name, :string
  end
end
