class AddCompositeUniqueConstraintToDecks < ActiveRecord::Migration[7.1]
  def change
    add_index :decks, %i[user_id title], unique: true
  end
end
