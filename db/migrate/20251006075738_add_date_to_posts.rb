class AddDateToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :date, :string
  end
end
