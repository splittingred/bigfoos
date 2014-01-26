a = Achievement.seed(:code) do |ach|
  ach.name = 'Offense'
  ach.code = 'score_as_front-1'
  ach.description = 'Get first score from the front'
  ach.prior = 0
  ach.stat = 'score_as_front'
  ach.operator = '>='
  ach.value = 1
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'So That\'s the Goal'
  ach.code = 'score_as_front-5'
  ach.description = 'Get 5 scores from the front'
  ach.prior = a.id
  ach.stat = 'score_as_front'
  ach.operator = '>='
  ach.value = 5
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Pass to Me!'
  ach.code = 'score_as_front-25'
  ach.description = 'Get 25 scores from the front'
  ach.prior = a.id
  ach.stat = 'score_as_front'
  ach.operator = '>='
  ach.value = 25
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Inside Corner'
  ach.code = 'score_as_front-50'
  ach.description = 'Get 50 scores from the front'
  ach.prior = a.id
  ach.stat = 'score_as_front'
  ach.operator = '>='
  ach.value = 50
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Outside Pull Corner Fake'
  ach.code = 'score_as_front-100'
  ach.description = 'Get 100 scores from the front'
  ach.prior = a.id
  ach.stat = 'score_as_front'
  ach.operator = '>='
  ach.value = 100
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'Goalies Hate Me'
  ach.code = 'score_as_front-250'
  ach.description = 'Get 250 scores from the front'
  ach.prior = a.id
  ach.stat = 'score_as_front'
  ach.operator = '>='
  ach.value = 250
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'I Practice Shots Alone'
  ach.code = 'score_as_front-500'
  ach.description = 'Get 500 scores from the front'
  ach.prior = a.id
  ach.stat = 'score_as_front'
  ach.operator = '>='
  ach.value = 500
end.first

a = Achievement.seed(:code) do |ach|
  ach.name = 'I Am Death, Bringer of Goals'
  ach.code = 'score_as_front-1000'
  ach.description = 'Get 1,000 scores from the front'
  ach.prior = a.id
  ach.stat = 'score_as_front'
  ach.operator = '>='
  ach.value = 1000
end.first







