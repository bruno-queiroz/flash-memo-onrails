json.isOk true
json.message "Get decks was made successfully"

json.data do
  json.array! @decks, partial: "decks/deck", as: :deck
end