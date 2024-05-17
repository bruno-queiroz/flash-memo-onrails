class CardsController < ApplicationController
    before_action :set_card, only: %i[ update destroy ]
    rescue_from ActiveRecord::RecordInvalid, with: :card_not_unique

    def search
        @cards = Card.where(
            "deck_id = :deck_id AND front LIKE :query OR back LIKE :query",
            {
                deck_id: params[:deck_id], query: "%#{params[:q]}%"
            }
        )

        if @cards.length == 0
            render :card_not_found
        end
    end

    def create
        @card = Card.create!(card_params)

        render :create, status: :created
    end

    def update
        @card.update!(update_card_params)
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
                :deck_id
            )
        end

        def update_card_params
            params.require(:card).permit(:front, :back)
        end

        def search_cards_params
            params.require(:card).permit(:deck_id, :query)
        end

        def card_not_unique
            render :card_not_unique, status: :unprocessable_entity
        end
end
