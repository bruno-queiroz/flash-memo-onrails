class DecksController < ApplicationController
    before_action :set_deck, only: %i[ destroy update ]
    rescue_from ActiveRecord::RecordInvalid, with: :deck_not_unique

    def index
        @decks = Deck.where("user_id = ?", current_user.id)
    end

    def create
        params[:deck][:user_id] = current_user.id
        @deck = Deck.create!(deck_params)

        render json: {isOk: true, msg: "Deck created successfully."}, status: :created
    end

    def update
        @deck.update!(update_deck_params)

        render json: {isOk: true, msg: "Deck updated successfully."}, status: :ok
    end

    def destroy
        @deck.destroy!

        render json: {isOk: true, msg: "Deck deleted successfully."}, status: :ok        
    end

    private
        def set_deck
            @deck = Deck.find(params[:id])
        end

        def deck_params
            params.require(:deck).permit(:title, :user_id)
        end

        def update_deck_params
            params.require(:deck).permit(:title)
        end

        def deck_not_unique
            render json: {isOk: false, msg: "You already have a deck with this name."}, status: :unprocessable_entity
        end
end
