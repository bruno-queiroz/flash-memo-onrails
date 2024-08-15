json.isOk true
json.msg 'Search cards was made successfully.'

json.data do
  json.array! @cards, partial: 'cards/card', as: :card
end
