class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :winner
      t.string :board, array: true, default: [["","",""],["","",""],["","",""]]
      t.string :turn
      t.timestamps null: false
    end
  end
end
