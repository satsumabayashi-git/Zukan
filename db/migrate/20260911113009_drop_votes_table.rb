class DropVotesTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :votes
  end
end
