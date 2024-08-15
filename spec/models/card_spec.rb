require 'rails_helper'

RSpec.describe 'Card' do
  it 'Should create card successfully.' do
    user = FactoryBot.create(:user)
    deck = FactoryBot.create(:deck, user:)
    card = FactoryBot.create(:card, deck:)

    expect(card).to be_valid
  end

  it 'One deck cannot have 2 cards with same front text' do
    user = FactoryBot.create(:user)
    deck = FactoryBot.create(:deck, user:)
    card = FactoryBot.create(:card, deck:)

    expect { FactoryBot.create(:card, deck:) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it '2 Different decks should be able to have cards with same front text.' do
    user = FactoryBot.create(:user)

    deck = FactoryBot.create(:deck, user:)
    deck2 = FactoryBot.create(:deck, { title: 'deck2', user: })

    card = FactoryBot.create(:card, deck:)
    card2 = FactoryBot.create(:card, deck: deck2)

    expect(card2).to be_valid
  end
end
