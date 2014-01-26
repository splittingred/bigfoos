Achievement.seed(:code) do |ach|
  ach.id = 22
  ach.name = 'I Found It!'
  ach.code = 'scores-1'
  ach.description = 'Got your first point!'
  ach.prior = 0
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 1
end

Achievement.seed(:code) do |ach|
  ach.id = 23
  ach.name = 'Kick It In'
  ach.code = 'scores-5'
  ach.description = 'Got 5 points'
  ach.prior = 22
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 5
end

Achievement.seed(:code) do |ach|
  ach.id = 24
  ach.name = 'Tappy Tap'
  ach.code = 'scores-25'
  ach.description = 'Score 25 points total'
  ach.prior = 23
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 25
end

Achievement.seed(:code) do |ach|
  ach.id = 25
  ach.name = 'Line It Up'
  ach.code = 'scores-50'
  ach.description = 'Got 50 points'
  ach.prior = 24
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 50
end

Achievement.seed(:code) do |ach|
  ach.id = 26
  ach.name = 'Scoremeister'
  ach.code = 'scores-100'
  ach.description = 'Got 100 points'
  ach.prior = 25
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 100
end

Achievement.seed(:code) do |ach|
  ach.id = 27
  ach.name = 'Dangerous'
  ach.code = 'scores-250'
  ach.description = 'Got 250 points'
  ach.prior = 26
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 250
end

Achievement.seed(:code) do |ach|
  ach.id = 28
  ach.name = 'GOOAALLLLLL'
  ach.code = 'scores-500'
  ach.description = 'Got 500 points'
  ach.prior = 27
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 500
end

Achievement.seed(:code) do |ach|
  ach.id = 29
  ach.name = 'Pele'
  ach.code = 'scores-1000'
  ach.description = 'Got 1,000 points'
  ach.prior = 28
  ach.stat = 'scores'
  ach.operator = '>='
  ach.value = 1000
end