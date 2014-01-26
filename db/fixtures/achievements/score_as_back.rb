a = Achievement.seed(:code) do |ach|
  ach.name = 'Long Shot'
  ach.code = 'score_as_back-1'
  ach.description = 'Get first score from the back'
  ach.prior = 0
  ach.stat = 'score_as_back'
  ach.operator = '>='
  ach.value = 1
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Hail Mary'
  ach.code = 'score_as_back-5'
  ach.description = 'Get 5 scores from the back'
  ach.prior = a.id
  ach.stat = 'score_as_back'
  ach.operator = '>='
  ach.value = 5
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Off The Back Wall'
  ach.code = 'score_as_back-25'
  ach.description = 'Get 25 scores from the back'
  ach.prior = a.id
  ach.stat = 'score_as_back'
  ach.operator = '>='
  ach.value = 25
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Snap, Crackle, Goal'
  ach.code = 'score_as_back-50'
  ach.description = 'Get 50 scores from the back'
  ach.prior = a.id
  ach.stat = 'score_as_back'
  ach.operator = '>='
  ach.value = 50
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Aim for the Middle'
  ach.code = 'score_as_back-100'
  ach.description = 'Get 100 scores from the back'
  ach.prior = a.id
  ach.stat = 'score_as_back'
  ach.operator = '>='
  ach.value = 100
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Slap Shooter'
  ach.code = 'score_as_back-250'
  ach.description = 'Get 250 scores from the back'
  ach.prior = a.id
  ach.stat = 'score_as_back'
  ach.operator = '>='
  ach.value = 250
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Goal Kicker of Doom'
  ach.code = 'score_as_back-500'
  ach.description = 'Get 500 scores from the back'
  ach.prior = a.id
  ach.stat = 'score_as_back'
  ach.operator = '>='
  ach.value = 500
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Cannon'
  ach.code = 'score_as_back-1000'
  ach.description = 'Get 1,000 scores from the back'
  ach.prior = a.id
  ach.stat = 'score_as_back'
  ach.operator = '>='
  ach.value = 1000
end.first







