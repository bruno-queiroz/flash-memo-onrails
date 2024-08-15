class AddCompositeUniqueConstraintToCards < ActiveRecord::Migration[7.1]
  def change
    add_index :cards, %i[deck_id front], unique: true
  end
end
