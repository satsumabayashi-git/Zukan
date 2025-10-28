class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.string :opinion
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
