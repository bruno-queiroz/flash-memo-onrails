class DecksController < ApplicationController
    before_action :set_deck, only: %i[ destroy update ]
    rescue_from ActiveRecord::RecordInvalid, with: :deck_not_unique

    def index
        @decks = Deck.joins(:cards)
            .where(user_id: current_user.id)
            .where('cards.review_at < now() OR cards.review_at IS NULL')
            .select(
                'decks.title',
                'MAX(decks.id) AS id',
                'COUNT(CASE WHEN cards.is_reset = \'t\' THEN 1 ELSE NULL END) AS reset_cards',
                'COUNT(CASE WHEN cards.is_reset = \'f\' AND cards.repetitions = 0 THEN 1 ELSE NULL END) AS new_cards',
                'COUNT(CASE WHEN cards.is_reset = \'f\' AND cards.repetitions >= 1 THEN 1 ELSE NULL END) AS review_cards'
            ).group('decks.title')

    end

    def due 
        deck_title = params[:deck_title]
        user_id = current_user.id

        @cards = Card.joins(:deck)
        .where(decks: { title: deck_title, user_id: user_id })
        .where(review_at: nil)
        .or(
          Card.joins(:deck)
              .where(decks: { title: deck_title, user_id: user_id })
              .where(review_at: Time.current)
        )
    end

    def create
        params[:deck][:user_id] = current_user.id
        @deck = Deck.create!(deck_params)

        render :create, status: :created
    end

    def update
        @deck.update!(update_deck_params)
    end

    def destroy
        @deck.destroy!
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
            render :deck_not_unique, status: :unprocessable_entity
        end
end
