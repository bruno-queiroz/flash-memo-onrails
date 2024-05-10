class AddCompositeUniqueConstraintToDecks < ActiveRecord::Migration[7.1]
  def change
    add_index :decks, [:user_id, :title], unique: true
  end
end
