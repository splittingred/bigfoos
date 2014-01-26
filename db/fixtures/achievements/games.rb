
Achievement.seed(:code) do |ach|
  ach.id = 13
  ach.name = 'Newbie'
  ach.code = 'games-1'
  ach.description = 'Played first game'
  ach.prior = 0
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 1
end

Achievement.seed(:code) do |ach|
  ach.id = 14
  ach.name = 'Getting the Hang of It'
  ach.code = 'games-5'
  ach.description = 'Played 5 games'
  ach.prior = 13
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 5
end

Achievement.seed(:code) do |ach|
  ach.id = 15
  ach.name = 'I Know the 2 Colors'
  ach.code = 'games-10'
  ach.description = 'Played 10 games'
  ach.prior = 14
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 10
end

Achievement.seed(:code) do |ach|
  ach.id = 16
  ach.name = 'Push and Pull Mean Something Now'
  ach.code = 'games-25'
  ach.description = 'Played 25 games'
  ach.prior = 15
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 25
end

Achievement.seed(:code) do |ach|
  ach.id = 17
  ach.name = 'I Can Pass!'
  ach.code = 'games-50'
  ach.description = 'Played 50 games'
  ach.prior = 16
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 50
end

Achievement.seed(:code) do |ach|
  ach.id = 18
  ach.name = 'I Like Foosball'
  ach.code = 'games-100'
  ach.description = 'Played 100 games'
  ach.prior = 17
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 100
end

Achievement.seed(:code) do |ach|
  ach.id = 19
  ach.name = 'I Get Work Done, Sometimes'
  ach.code = 'games-250'
  ach.description = 'Played 250 games'
  ach.prior = 18
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 250
end

Achievement.seed(:code) do |ach|
  ach.id = 20
  ach.name = 'I Stay After Work to Practice'
  ach.code = 'games-500'
  ach.description = 'Played 500 games'
  ach.prior = 19
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 500
end

Achievement.seed(:code) do |ach|
  ach.id = 21
  ach.name = 'I Dream of Foos'
  ach.code = 'games-1000'
  ach.description = 'Played 1,000 games'
  ach.prior = 20
  ach.stat = 'games'
  ach.operator = '>='
  ach.value = 1000
end