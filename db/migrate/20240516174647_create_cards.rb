class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :front, null: false
      t.string :back, null: false
      t.boolean :is_reset, default: false
      t.date :review_at, null: false
      t.float :ease_factor, null: false
      t.integer :interval, null: false
      t.integer :repetitions, null: false

      t.timestamps
    end
  end
end
