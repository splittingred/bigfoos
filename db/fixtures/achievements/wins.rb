Achievement.seed(:code) do |ach|
  ach.id = 1
  ach.name = 'Winnar!'
  ach.code = 'wins-1'
  ach.description = 'Got your first win!'
  ach.prior = 0
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 1
end

Achievement.seed(:code) do |ach|
  ach.id = 2
  ach.name = 'Doin Good'
  ach.code = 'wins-5'
  ach.description = 'Got 5 wins'
  ach.prior = 1
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 5
end

Achievement.seed(:code) do |ach|
  ach.id = 3
  ach.name = 'Solid Performer'
  ach.code = 'wins-10'
  ach.description = 'Got 10 wins'
  ach.prior = 2
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 10
end

Achievement.seed(:code) do |ach|
  ach.id = 4
  ach.name = 'Crack-a-lackin'
  ach.code = 'wins-25'
  ach.description = 'Got 25 wins'
  ach.prior = 3
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 25
end

Achievement.seed(:code) do |ach|
  ach.id = 5
  ach.name = 'Valuable Player'
  ach.code = 'wins-50'
  ach.description = 'Got 50 wins'
  ach.prior = 4
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 50
end

Achievement.seed(:code) do |ach|
  ach.id = 6
  ach.name = 'Game Changer'
  ach.code = 'wins-100'
  ach.description = 'Got 100 wins'
  ach.prior = 5
  ach.stat = 'wins'
  ach.operator = '>='
  ach.value = 100
end
