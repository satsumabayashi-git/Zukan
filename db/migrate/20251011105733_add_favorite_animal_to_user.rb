class AddFavoriteAnimalToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :favorite_animal, :string
  end
end
