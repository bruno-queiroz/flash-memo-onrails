class DecksController < ApplicationController
    before_action :set_deck, only: %i[ destroy update ]

    def index
        @decks = Deck.where("user_id = ?", current_user.id)
    end

    def create
        params[:deck][:user_id] = current_user.id
        @deck = Deck.new(deck_params)

        if @deck.save
            render json: {isOk: true, msg: "Deck created successfully."}, status: :created
        else
            render json: {isOk: false, msg: "Something went wrong creating deck."}, status: :unprocessable_entity
        end

    end

    def update
        if @deck.update(update_deck_params)
            render json: {isOk: true, msg: "Deck updated successfully."}
        else
            render json: {isOk: false, msg: "Something went wrong updating deck."}
        end
    end

    def destroy
        @deck.destroy!

        render json: {isOk: true, msg: "Deck deleted successfully."}
    rescue
        render json: {isOk: false, msg: "Something went wrong deleting deck."}
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
end
