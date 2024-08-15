require 'rails_helper'

RSpec.describe 'Deck' do
  it 'Should create deck successfully.' do
    user = FactoryBot.create(:user)
    deck = FactoryBot.create(:deck, user:)

    expect(deck).to be_valid
  end

  it 'User should not have two decks with same title.' do
    user = FactoryBot.create(:user)
    deck = FactoryBot.create(:deck, user:)

    expect { FactoryBot.create(:deck, user:) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it '2 Different users should be able to have decks with same title.' do
    user = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user, { name: 'user2' })

    deck = FactoryBot.create(:deck, user:)
    deck2 = FactoryBot.create(:deck, user: user2)

    expect(deck2).to be_valid
  end
end
