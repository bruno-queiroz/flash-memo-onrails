json.isOk true
json.msg "Get decks was made successfully."

json.data do
  json.array! @decks, partial: "decks/deck", as: :deck
end