a = Achievement.seed(:code) do |ach|
  ach.name = 'Failure'
  ach.code = 'scored_against-1'
  ach.description = 'Allow your first goal against you'
  ach.prior = 0
  ach.stat = 'scored_against'
  ach.operator = '>='
  ach.value = 1
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'You Lose, You Learn'
  ach.code = 'scored_against-5'
  ach.description = 'Allow 5 goals'
  ach.prior = a.id
  ach.stat = 'scored_against'
  ach.operator = '>='
  ach.value = 5
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'It Happens to Everyone'
  ach.code = 'scored_against-25'
  ach.description = 'Allow 25 goals'
  ach.prior = a.id
  ach.stat = 'scored_against'
  ach.operator = '>='
  ach.value = 25
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Near-sighted'
  ach.code = 'scored_against-50'
  ach.description = 'Allow 50 goals'
  ach.prior = a.id
  ach.stat = 'scored_against'
  ach.operator = '>='
  ach.value = 50
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Line It Up Next Time'
  ach.code = 'scored_against-100'
  ach.description = 'Allow 100 goals'
  ach.prior = a.id
  ach.stat = 'scored_against'
  ach.operator = '>='
  ach.value = 100
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Not a Team Asset'
  ach.code = 'scored_against-250'
  ach.description = 'Allow 250 goals'
  ach.prior = a.id
  ach.stat = 'scored_against'
  ach.operator = '>='
  ach.value = 250
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Are You Even Playing?'
  ach.code = 'scored_against-500'
  ach.description = 'Allow 500 goals'
  ach.prior = a.id
  ach.stat = 'scored_against'
  ach.operator = '>='
  ach.value = 500
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'rm -rf / please'
  ach.code = 'scored_against-1000'
  ach.description = 'Allow 1,000 goals'
  ach.prior = a.id
  ach.stat = 'scored_against'
  ach.operator = '>='
  ach.value = 1000
end.first







