class CardsController < ApplicationController
  before_action :set_card, only: %i[update destroy interval]
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordInvalid, with: :card_not_unique

  def search
    @cards = Card.where(deck_id: params[:deck_id])
                 .where('front LIKE :query OR back LIKE :query', {
                          query: params[:q]
                        })

    return unless @cards.length == 0

    render :card_not_found
  end

  def create
    @card = Card.create!(card_params)

    render :create, status: :created
  end

  def update
    @card.update!(update_card_params)
  end

  def interval
    params[:card][:review_at] = if params[:card][:is_reset]
                                  Time.utc(1970)
                                else
                                  Date.today + params[:card][:interval]
                                end

    @card.update!(update_interval_params)
  end

  def destroy
    @card.destroy!
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(
      :front,
      :back,
      :ease_factor,
      :interval,
      :repetitions,
      :deck_id,
      :review_at
    )
  end

  def update_card_params
    params.require(:card).permit(:front, :back)
  end

  def update_interval_params
    params.require(:card).permit(
      :ease_factor,
      :interval,
      :is_reset,
      :repetitions,
      :review_at
    )
  end

  def search_cards_params
    params.require(:card).permit(:deck_id, :query)
  end

  def card_not_unique
    render :card_not_unique, status: :unprocessable_entity
  end
end
