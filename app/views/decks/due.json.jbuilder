json.isOk true
json.msg 'Due cards request was made successfully.'

json.data @cards do |card|
  json.extract! card, :id, :front, :back, :interval, :repetitions, :is_reset, :ease_factor, :review_at
end
