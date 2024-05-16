class ChangeColumnReviewAt < ActiveRecord::Migration[7.1]
  def change
    change_column :cards, :review_at, :date, null: true
  end
end
