
Achievement.seed(:code) do |ach|
  ach.id = 7
  ach.name = 'Try, Try Again'
  ach.code = 'losses-1'
  ach.description = 'Got your first loss'
  ach.prior = 0
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 1
end

Achievement.seed(:code) do |ach|
  ach.id = 8
  ach.name = 'Stop Spinning'
  ach.code = 'losses-5'
  ach.description = 'Got 5 losses'
  ach.prior = 7
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 5
end

Achievement.seed(:code) do |ach|
  ach.id = 9
  ach.name = 'Getting better...?'
  ach.code = 'losses-10'
  ach.description = 'Got 10 losses'
  ach.prior = 8
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 10
end

Achievement.seed(:code) do |ach|
  ach.id = 10
  ach.name = 'Time to Play on the Kiddo Table'
  ach.code = 'losses-25'
  ach.description = 'Got 25 losses'
  ach.prior = 9
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 25
end

Achievement.seed(:code) do |ach|
  ach.id = 11
  ach.name = 'Maybe This Just Isnt For You'
  ach.code = 'losses-50'
  ach.description = 'Got 50 losses'
  ach.prior = 10
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 50
end

Achievement.seed(:code) do |ach|
  ach.id = 12
  ach.name = 'Can He Play on Your Team?'
  ach.code = 'losses-100'
  ach.description = 'Got 100 losses'
  ach.prior = 11
  ach.stat = 'losses'
  ach.operator = '>='
  ach.value = 100
end