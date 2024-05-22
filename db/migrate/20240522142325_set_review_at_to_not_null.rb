class SetReviewAtToNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column :cards, :review_at, :date, null: false
  end
end
