class CardsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :card_not_unique

    def create
        @card = Card.create!(card_params)

        render :create, status: :created
    end

    private
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

        def card_not_unique
            render :card_not_unique, status: :unprocessable_entity
        end
end
